import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/symptom_category.dart';

part 'symptom_model.freezed.dart';
part 'symptom_model.g.dart';

/// App-level model for a symptom definition (reference / lookup data).
///
/// Maps from a [SymptomsTable] row. This table is small, static after seed,
/// and cached in memory by SymptomDao. Uses type-safe [SymptomCategory] enum.
@freezed
abstract class SymptomModel with _$SymptomModel {
  const factory SymptomModel({
    /// Database row ID from symptoms table. Stable identifier.
    required int id,

    /// Human-readable symptom name (e.g. 'headache'). Unique.
    required String name,

    /// Category group for this symptom.
    required SymptomCategory category,

    /// Flutter icon identifier string (e.g. 'Icons.mood').
    required String iconName,

    /// Optional emoji string for mood symptoms. Null for non-mood symptoms.
    String? emoji,

    /// Sort order for display in the symptom grid.
    required int displayOrder,
  }) = _SymptomModel;

  factory SymptomModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomModelFromJson(json);
}
