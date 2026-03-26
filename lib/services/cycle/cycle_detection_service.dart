import 'package:drift/drift.dart';

import '../../data/database/app_database.dart';
import '../../data/database/daos/cycle_dao.dart';
import '../../data/database/daos/period_log_dao.dart';

class CycleDetectionService {
  final CycleDao _cycleDao;
  final PeriodLogDao _periodLogDao;
  final AppDatabase _db;

  CycleDetectionService({
    required CycleDao cycleDao,
    required PeriodLogDao periodLogDao,
    required AppDatabase db,
  })  : _cycleDao = cycleDao,
        _periodLogDao = periodLogDao,
        _db = db;

  Future<void> processLog(DateTime date, bool isPeriodDay) async {
    final allLogs = await _periodLogDao.getLogsForDateRange(
      DateTime(2000, 1, 1),
      DateTime(2100, 12, 31),
    );

    if (allLogs.isEmpty) {
      await _closeOrphanedOpenCycle();
      return;
    }

    allLogs.sort((a, b) => a.date.compareTo(b.date));
    final runs =
        _buildRuns(allLogs.map((l) => _dateOnly(l.date)).toList());
    await _reconcileCycles(runs);
  }

  List<List<DateTime>> _buildRuns(List<DateTime> sortedDates) {
    if (sortedDates.isEmpty) return [];
    final runs = <List<DateTime>>[];
    var current = <DateTime>[sortedDates.first];
    for (int i = 1; i < sortedDates.length; i++) {
      final prev = sortedDates[i - 1];
      final curr = sortedDates[i];
      if (curr.difference(prev).inDays <= 1) {
        current.add(curr);
      } else {
        runs.add(current);
        current = [curr];
      }
    }
    runs.add(current);
    return runs;
  }

  Future<void> _reconcileCycles(List<List<DateTime>> runs) async {
    final now = DateTime.now().toIso8601String();
    final desiredStarts = {for (final r in runs) _dateOnly(r.first)};
    final allCycles = await _loadAllCycles();
    for (final cycle in allCycles) {
      if (!desiredStarts.contains(_dateOnly(cycle.startDate))) {
        await _deleteCycle(cycle.id);
      }
    }
    final remaining = await _loadAllCycles();
    final cycleByStart = {
      for (final c in remaining) _dateOnly(c.startDate): c,
    };
    for (int i = 0; i < runs.length; i++) {
      final run = runs[i];
      final runStart = run.first;
      final periodLen = run.length;
      final isLast = i == runs.length - 1;
      DateTime? endDate;
      int? cycleLen;
      if (!isLast) {
        final nextRunStart = runs[i + 1].first;
        endDate = nextRunStart.subtract(const Duration(days: 1));
        cycleLen = nextRunStart.difference(runStart).inDays;
      }
      final endDateStr = endDate?.toIso8601String().substring(0, 10);
      final existing = cycleByStart[runStart];
      int cycleId;
      if (existing == null) {
        cycleId = await _cycleDao.insertCycle(CyclesTableCompanion(
          startDate: Value(runStart.toIso8601String().substring(0, 10)),
          endDate: endDateStr != null
              ? Value(endDateStr)
              : const Value.absent(),
          cycleLength:
              cycleLen != null ? Value(cycleLen) : const Value.absent(),
          periodLength: Value(periodLen),
          isPredicted: const Value(0),
          createdAt: Value(now),
          updatedAt: Value(now),
        ));
      } else {
        cycleId = existing.id;
        final existingEndStr =
            existing.endDate?.toIso8601String().substring(0, 10);
        if (existing.periodLength != periodLen ||
            existingEndStr != endDateStr ||
            existing.cycleLength != cycleLen) {
          await _cycleDao.updateCycle(
            cycleId,
            CyclesTableCompanion(
              endDate: endDateStr != null
                  ? Value(endDateStr)
                  : const Value(null),
              cycleLength:
                  cycleLen != null ? Value(cycleLen) : const Value(null),
              periodLength: Value(periodLen),
              updatedAt: Value(now),
            ),
          );
        }
      }
      await _linkLogsToCycle(run, cycleId, now);
    }
  }

  Future<List<_CycleRow>> _loadAllCycles() async {
    final rows = await (_db.select(_db.cyclesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.startDate)]))
        .get();
    return rows
        .map((r) => _CycleRow(
              id: r.id,
              startDate: DateTime.parse(r.startDate),
              endDate: r.endDate != null ? DateTime.parse(r.endDate!) : null,
              cycleLength: r.cycleLength,
              periodLength: r.periodLength,
            ))
        .toList();
  }

  Future<void> _deleteCycle(int id) async {
    await (_db.delete(_db.cyclesTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> _linkLogsToCycle(
    List<DateTime> run,
    int cycleId,
    String now,
  ) async {
    for (final day in run) {
      final dateStr = day.toIso8601String().substring(0, 10);
      await (_db.update(_db.periodLogsTable)
            ..where((t) => t.date.equals(dateStr)))
          .write(PeriodLogsTableCompanion(
        cycleId: Value(cycleId),
        updatedAt: Value(now),
      ));
    }
  }

  Future<void> _closeOrphanedOpenCycle() async {
    final openCycle = await _cycleDao.getCurrentCycle();
    if (openCycle == null) return;
    final logs = await _periodLogDao.getLogsForCycle(openCycle.id);
    if (logs.isEmpty) {
      await _deleteCycle(openCycle.id);
    }
  }

  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}

class _CycleRow {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;
  final int? cycleLength;
  final int? periodLength;

  const _CycleRow({
    required this.id,
    required this.startDate,
    this.endDate,
    this.cycleLength,
    this.periodLength,
  });
}
