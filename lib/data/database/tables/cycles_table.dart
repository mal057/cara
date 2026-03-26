import 'package:drift/drift.dart';

/// Stores one row per menstrual cycle.
///
/// Indexes (per Karla Note 1 — SQLCipher performance):
///   - idx_cycles_start_date on (start_date): getCompletedCycles and
///     getCurrentCycle both ORDER BY / filter start_date. start_date is
///     UNIQUE, but a named index makes the query planner explicit.
@TableIndex(name: 'idx_cycles_start_date', columns: {#startDate})
class CyclesTable extends Table {
  @override
  String get tableName => 'cycles';

  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// ISO 8601 date of cycle start (first day of period). NOT NULL, UNIQUE.
  TextColumn get startDate => text().unique()();

  /// ISO 8601 date of cycle end (day before next period). NULL while ongoing.
  TextColumn get endDate => text().nullable()();

  /// Computed cycle length in days (end_date - start_date + 1).
  /// NULL until the cycle is closed.
  IntColumn get cycleLength => integer().nullable()();

  /// Number of period days in this cycle. NULL until cycle is closed.
  IntColumn get periodLength => integer().nullable()();

  /// 1 = this is a predicted (not user-confirmed) cycle. Default 0.
  /// Enforced as 0/1 by CHECK constraint in customConstraints.
  IntColumn get isPredicted => integer().withDefault(const Constant(0))();

  /// ISO 8601 timestamp — set once on insert.
  TextColumn get createdAt => text()();

  /// ISO 8601 timestamp — updated on every write.
  TextColumn get updatedAt => text()();

  @override
  List<String> get customConstraints =>
      ['CHECK (is_predicted IN (0, 1))'];
}
