import 'package:drift/drift.dart';

import 'cycles_table.dart';

/// Stores one row per day that a period is logged.
///
/// Indexes (per Karla Note 1 — SQLCipher performance):
///   - idx_period_logs_date on (date): getLogsForDateRange filters and orders
///     by date. date is UNIQUE so the constraint doubles as an index, but the
///     explicit named index is required by the architecture spec.
///   - idx_period_logs_cycle_id on (cycle_id): getLogsForCycle filters by
///     cycle_id; without an index this would full-scan the table.
@TableIndex(name: 'idx_period_logs_date', columns: {#date})
@TableIndex(name: 'idx_period_logs_cycle_id', columns: {#cycleId})
class PeriodLogsTable extends Table {
  @override
  String get tableName => 'period_logs';

  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// ISO 8601 date. NOT NULL, UNIQUE — only one log entry per calendar day.
  TextColumn get date => text().unique()();

  /// Foreign key to cycles.id. NULL if this log is not yet assigned to a cycle
  /// (e.g. entered before the cycle row is created).
  IntColumn get cycleId =>
      integer().nullable().references(CyclesTable, #id)();

  /// Flow intensity: 'light', 'medium', or 'heavy'. NOT NULL.
  TextColumn get flowIntensity => text()();

  /// Flow color: 'red', 'dark_red', 'brown', or 'pink'. Nullable.
  TextColumn get flowColor => text().nullable()();

  /// ISO 8601 timestamp — set once on insert.
  TextColumn get createdAt => text()();

  /// ISO 8601 timestamp — updated on every write.
  TextColumn get updatedAt => text()();
}
