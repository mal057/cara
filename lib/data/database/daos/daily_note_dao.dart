import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/daily_notes_table.dart';
import '../../models/daily_note_model.dart';

part 'daily_note_dao.g.dart';

/// Data access object for the daily_notes table.
///
/// Supports one note per calendar day via upsert (INSERT OR REPLACE) so the
/// caller does not need to know whether a note already exists for a given date.
@DriftAccessor(tables: [DailyNotesTable])
class DailyNoteDao extends DatabaseAccessor<AppDatabase>
    with _$DailyNoteDaoMixin {
  DailyNoteDao(super.db);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// Returns the daily note for [date], or null if none has been written.
  ///
  /// Uses the idx_daily_notes_date index for an efficient point lookup.
  Future<DailyNoteModel?> getNoteForDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    final row = await (select(dailyNotesTable)
          ..where((t) => t.date.equals(dateStr)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Inserts or replaces the daily note described by [note].
  ///
  /// If a row already exists for the same date (UNIQUE constraint), the
  /// existing row is fully replaced with the new values — effectively an
  /// upsert without needing to know the existing row id.
  Future<void> upsertNote(DailyNotesTableCompanion note) async {
    await into(dailyNotesTable).insertOnConflictUpdate(note);
  }

  // ---------------------------------------------------------------------------
  // Mapper
  // ---------------------------------------------------------------------------

  DailyNoteModel _rowToModel(DailyNotesTableData row) {
    return DailyNoteModel(
      id: row.id,
      date: DateTime.parse(row.date),
      content: row.content,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }
}
