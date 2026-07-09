import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/symptom_category.dart';

part 'symptom_stat_model.freezed.dart';

/// Aggregated symptom statistics computed by SQL GROUP BY.
///
/// Returned by [SymptomDao.getAggregatedStats] — NOT persisted directly.
/// Built from a raw SQL aggregation query so that the app never loads all
/// symptom_entries into memory (per Karla Note 3).
@freezed
abstract class SymptomStat with _$SymptomStat {
  const factory SymptomStat({
    /// Foreign key to symptoms.id — the symptom being aggregated.
    required int symptomId,

    /// Human-readable symptom name (from joined symptoms row).
    required String symptomName,

    /// Symptom category (from joined symptoms row).
    required SymptomCategory category,

    /// Flutter icon identifier string (from joined symptoms row).
    required String iconName,

    /// Optional emoji string for mood symptoms (from joined symptoms row).
    String? emoji,

    /// Number of times this symptom was logged in the requested date range.
    required int occurrenceCount,

    /// Mean severity across all entries in the date range (1.0–3.0).
    required double averageSeverity,
  }) = _SymptomStat;
}
