import 'package:drift/drift.dart';

import 'symptoms_table.dart';

/// Records a single symptom logged for a specific date.
///
/// Indexes (per Karla Note 1 — SQLCipher performance):
///   - idx_symptom_entries_date_symptom_id composite index on (date, symptom_id):
///     getEntriesForDate filters by date; getAggregatedStats groups by symptom_id
///     over a date range. A composite index covers both access patterns efficiently
///     and is explicitly required by the architecture spec.
@TableIndex(
  name: 'idx_symptom_entries_date_symptom_id',
  columns: {#date, #symptomId},
)
class SymptomEntriesTable extends Table {
  @override
  String get tableName => 'symptom_entries';

  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// ISO 8601 date of the log entry. NOT NULL.
  /// Not UNIQUE — a user can log multiple symptoms for the same date.
  TextColumn get date => text()();

  /// Foreign key to symptoms.id. NOT NULL.
  IntColumn get symptomId =>
      integer().references(SymptomsTable, #id)();

  /// Severity level: 1 = mild, 2 = moderate, 3 = severe.
  /// Enforced as CHECK (severity BETWEEN 1 AND 3) via customConstraints.
  IntColumn get severity => integer()();

  /// ISO 8601 timestamp — set once on insert.
  TextColumn get createdAt => text()();

  @override
  List<String> get customConstraints =>
      ['CHECK (severity BETWEEN 1 AND 3)'];
}
