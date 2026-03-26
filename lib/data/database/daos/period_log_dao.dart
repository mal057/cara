import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/period_logs_table.dart';
import '../../models/period_log_model.dart';
import '../../../core/enums/flow_color.dart';
import '../../../core/enums/flow_intensity.dart';

part 'period_log_dao.g.dart';

/// Data access object for the period_logs table.
///
/// All date-range queries use the indexed `date` column (Karla Note 1).
@DriftAccessor(tables: [PeriodLogsTable])
class PeriodLogDao extends DatabaseAccessor<AppDatabase>
    with _$PeriodLogDaoMixin {
  PeriodLogDao(super.db);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// Returns all period logs with dates between [start] and [end] inclusive,
  /// ordered chronologically. Uses the idx_period_logs_date index.
  Future<List<PeriodLogModel>> getLogsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final startStr = start.toIso8601String().substring(0, 10);
    final endStr = end.toIso8601String().substring(0, 10);

    final rows = await (select(periodLogsTable)
          ..where((t) => t.date.isBetweenValues(startStr, endStr))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Inserts a new period log row and returns the auto-generated row id.
  Future<int> insertLog(PeriodLogsTableCompanion log) =>
      into(periodLogsTable).insert(log);

  /// Updates the period log identified by [id] with [log] companion data.
  ///
  /// Returns `true` if exactly one row was modified; `false` if not found.
  Future<bool> updateLog(int id, PeriodLogsTableCompanion log) async {
    final affected = await (update(periodLogsTable)
          ..where((t) => t.id.equals(id)))
        .write(log);
    return affected == 1;
  }

  /// Deletes the period log identified by [id].
  ///
  /// Returns `true` if exactly one row was deleted; `false` if not found.
  Future<bool> deleteLog(int id) async {
    final affected = await (delete(periodLogsTable)
          ..where((t) => t.id.equals(id)))
        .go();
    return affected == 1;
  }

  /// Returns all period logs belonging to [cycleId], ordered chronologically.
  /// Uses the idx_period_logs_cycle_id index.
  Future<List<PeriodLogModel>> getLogsForCycle(int cycleId) async {
    final rows = await (select(periodLogsTable)
          ..where((t) => t.cycleId.equals(cycleId))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  // ---------------------------------------------------------------------------
  // Mapper
  // ---------------------------------------------------------------------------

  PeriodLogModel _rowToModel(PeriodLogsTableData row) {
    return PeriodLogModel(
      id: row.id,
      date: DateTime.parse(row.date),
      cycleId: row.cycleId,
      flowIntensity: FlowIntensity.values.firstWhere(
        (e) => e.name == row.flowIntensity,
      ),
      flowColor:
          row.flowColor != null ? FlowColor.fromString(row.flowColor!) : null,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }
}
