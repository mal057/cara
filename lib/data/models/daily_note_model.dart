import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_note_model.freezed.dart';
part 'daily_note_model.g.dart';

/// App-level model for a free-form daily note.
///
/// Maps from a [DailyNotesTable] row. One note per calendar day.
/// Content is capped at 500 characters (enforced at the UI layer by NoteInput).
@freezed
abstract class DailyNoteModel with _$DailyNoteModel {
  const factory DailyNoteModel({
    /// Database row ID from daily_notes table.
    required int id,

    /// The calendar date this note belongs to. Unique — one note per day.
    required DateTime date,

    /// Free-form note text. Max 500 characters.
    required String content,

    /// When this row was first inserted.
    required DateTime createdAt,

    /// When this row was last updated (upsert sets this).
    required DateTime updatedAt,
  }) = _DailyNoteModel;

  factory DailyNoteModel.fromJson(Map<String, dynamic> json) =>
      _$DailyNoteModelFromJson(json);
}
