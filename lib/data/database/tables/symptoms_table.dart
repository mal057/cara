import 'package:drift/drift.dart';

/// Reference / lookup table for symptom types.
///
/// This table is small (15–30 rows), static after initial seed, and read
/// frequently. It is cached in memory by SymptomDao.getAllSymptoms().
/// No indexes beyond the PK are needed for a table this size.
class SymptomsTable extends Table {
  @override
  String get tableName => 'symptoms';

  /// Auto-incrementing primary key. The numeric ID is stable — it is the
  /// canonical symptom type identifier used by symptom_entries.
  IntColumn get id => integer().autoIncrement()();

  /// Human-readable symptom name (e.g. 'headache'). NOT NULL, UNIQUE.
  TextColumn get name => text().unique()();

  /// Category group: 'mood', 'pain', 'energy', 'skin', 'digestion',
  /// 'sleep', or 'other'. NOT NULL.
  TextColumn get category => text()();

  /// Flutter icon identifier string (e.g. 'Icons.mood'). NOT NULL.
  TextColumn get iconName => text()();

  /// Sort order for display in the symptom grid. NOT NULL.
  IntColumn get displayOrder => integer()();
}
