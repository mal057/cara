import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/symptom_severity.dart';
import 'symptom_model.dart';

part 'symptom_entry_model.freezed.dart';
part 'symptom_entry_model.g.dart';

/// App-level model for a single symptom log on a specific date.
///
/// Maps from a [SymptomEntriesTable] row, enriched with the resolved
/// [SymptomModel] so UI layers never have to look up the symptom separately.
@freezed
abstract class SymptomEntryModel with _$SymptomEntryModel {
  const factory SymptomEntryModel({
    /// Database row ID from symptom_entries table.
    required int id,

    /// The calendar date this entry covers.
    required DateTime date,

    /// Foreign key to the symptom definition.
    required int symptomId,

    /// Resolved symptom definition. Null if not yet joined (bare DB row).
    SymptomModel? symptom,

    /// Severity of this symptom on this date.
    required SymptomSeverity severity,

    /// When this row was first inserted.
    required DateTime createdAt,
  }) = _SymptomEntryModel;

  factory SymptomEntryModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomEntryModelFromJson(json);
}
