import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/cycles_table.dart';
import '../tables/period_logs_table.dart';
import '../tables/symptom_entries_table.dart';
import '../tables/symptoms_table.dart';
import '../../models/cycle_model.dart';
import '../../models/month_data_model.dart';
import '../../models/period_log_model.dart';
import '../../models/symptom_entry_model.dart';
import '../../models/symptom_model.dart';
import '../../../core/enums/flow_color.dart';
import '../../../core/enums/flow_intensity.dart';
import '../../../core/enums/symptom_category.dart';
import '../../../core/enums/symptom_severity.dart';

part 'cycle_dao.g.dart';

/// Data access object for the cycles table.
///
/// Also provides [getMonthData] which joins period_logs and symptom_entries
/// in a single query to pre-populate the calendar month cache (Karla Note 2).
@DriftAccessor(tables: [
  CyclesTable,
  PeriodLogsTable,
  SymptomEntriesTable,
  SymptomsTable,
])
class CycleDao extends DatabaseAccessor<AppDatabase> with _$CycleDaoMixin {
  CycleDao(super.db);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// Returns the [limit] most recently started completed cycles (end_date NOT
  /// NULL), ordered newest-first. Defaults to last 6 cycles for the insights
  /// screen and prediction algorithm.
  Future<List<CycleModel>> getCompletedCycles({int limit = 6}) async {
    final rows = await (select(cyclesTable)
          ..where((t) => t.endDate.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
          ..limit(limit))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Returns the currently active (ongoing) cycle — the latest row where
  /// end_date IS NULL — or null if no cycle is open.
  Future<CycleModel?> getCurrentCycle() async {
    final row = await (select(cyclesTable)
          ..where((t) => t.endDate.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Returns ALL cycles (both open and closed) ordered by start_date ascending.
  /// Used by the calendar provider to assign phase colors across multiple cycles.
  Future<List<CycleModel>> getAllCyclesSorted() async {
    final rows = await (select(cyclesTable)
          ..orderBy([(t) => OrderingTerm.asc(t.startDate)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Inserts a new cycle row and returns the auto-generated row id.
  Future<int> insertCycle(CyclesTableCompanion cycle) =>
      into(cyclesTable).insert(cycle);

  /// Updates the cycle identified by [id] with [cycle] companion data.
  ///
  /// Returns `true` if exactly one row was modified; `false` if the id was
  /// not found.
  Future<bool> updateCycle(int id, CyclesTableCompanion cycle) async {
    final affected = await (update(cyclesTable)
          ..where((t) => t.id.equals(id)))
        .write(cycle);
    return affected == 1;
  }

  /// Fetches all period logs AND all symptom entries (with joined symptom
  /// definitions) for [month] in a single database round-trip.
  ///
  /// The date range is the first through last calendar day of the month.
  /// Results are used by [monthDataCacheProvider] to populate the calendar
  /// without per-day queries (Karla Note 2).
  Future<MonthData> getMonthData(DateTime month) async {
    final startStr =
        DateTime(month.year, month.month, 1).toIso8601String().substring(0, 10);
    // Last day of month: day-0 of next month = last day of current month.
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final endStr = lastDay.toIso8601String().substring(0, 10);

    // Fetch period logs for the month range.
    final logRows = await (select(periodLogsTable)
          ..where((t) => t.date.isBetweenValues(startStr, endStr))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();

    // Fetch symptom entries for the month range with joined symptom definitions.
    final entryQuery = select(symptomEntriesTable).join([
      innerJoin(
        symptomsTable,
        symptomsTable.id.equalsExp(symptomEntriesTable.symptomId),
      ),
    ])
      ..where(symptomEntriesTable.date.isBetweenValues(startStr, endStr))
      ..orderBy([OrderingTerm.asc(symptomEntriesTable.date)]);

    final entryRows = await entryQuery.get();

    final periodLogs = logRows.map(_periodLogRowToModel).toList();
    final symptomEntries = entryRows.map((row) {
      final entry = row.readTable(symptomEntriesTable);
      final symptom = row.readTable(symptomsTable);
      return _symptomEntryRowToModel(entry, symptomRow: symptom);
    }).toList();

    return MonthData(periodLogs: periodLogs, symptomEntries: symptomEntries);
  }

  /// Watches the currently active cycle and emits only when the value
  /// actually changes (Karla Note 7 — limit watchers, use distinct()).
  ///
  /// Returns `null` when there is no open cycle.
  Stream<CycleModel?> watchCurrentCycle() {
    return (select(cyclesTable)
          ..where((t) => t.endDate.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
          ..limit(1))
        .watchSingleOrNull()
        .distinct()
        .map((row) => row == null ? null : _rowToModel(row));
  }

  // ---------------------------------------------------------------------------
  // Mappers
  // ---------------------------------------------------------------------------

  CycleModel _rowToModel(CyclesTableData row) {
    return CycleModel(
      id: row.id,
      startDate: DateTime.parse(row.startDate),
      endDate: row.endDate != null ? DateTime.parse(row.endDate!) : null,
      cycleLength: row.cycleLength,
      periodLength: row.periodLength,
      isPredicted: row.isPredicted == 1,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }

  PeriodLogModel _periodLogRowToModel(PeriodLogsTableData row) {
    return PeriodLogModel(
      id: row.id,
      date: DateTime.parse(row.date),
      cycleId: row.cycleId,
      flowIntensity: FlowIntensity.values.firstWhere(
        (e) => e.name == row.flowIntensity,
      ),
      flowColor: row.flowColor != null
          ? FlowColor.fromString(row.flowColor!)
          : null,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }

  SymptomEntryModel _symptomEntryRowToModel(
    SymptomEntriesTableData entry, {
    required SymptomsTableData symptomRow,
  }) {
    return SymptomEntryModel(
      id: entry.id,
      date: DateTime.parse(entry.date),
      symptomId: entry.symptomId,
      symptom: SymptomModel(
        id: symptomRow.id,
        name: symptomRow.name,
        category: SymptomCategory.fromString(symptomRow.category),
        iconName: symptomRow.iconName,
        displayOrder: symptomRow.displayOrder,
      ),
      severity: SymptomSeverity.fromValue(entry.severity),
      createdAt: DateTime.parse(entry.createdAt),
    );
  }
}
