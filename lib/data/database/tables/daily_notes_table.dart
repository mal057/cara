import 'package:drift/drift.dart';

/// Stores free-form daily notes — one per calendar day.
///
/// Indexes (per Karla Note 1 — SQLCipher performance):
///   - idx_daily_notes_date on (date): getNoteForDate looks up by date.
///     date is UNIQUE so the constraint covers point lookups, but the
///     explicit named index is required by the architecture spec.
@TableIndex(name: 'idx_daily_notes_date', columns: {#date})
class DailyNotesTable extends Table {
  @override
  String get tableName => 'daily_notes';

  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// ISO 8601 date. NOT NULL, UNIQUE — one note per calendar day.
  TextColumn get date => text().unique()();

  /// Free-form note text. Max 500 characters enforced at the application layer
  /// (NoteInput widget char counter). NOT NULL.
  TextColumn get content => text()();

  /// ISO 8601 timestamp — set once on insert.
  TextColumn get createdAt => text()();

  /// ISO 8601 timestamp — updated on every upsert.
  TextColumn get updatedAt => text()();
}
