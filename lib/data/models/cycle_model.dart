import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/cycle_phase.dart';
import 'period_log_model.dart';

part 'cycle_model.freezed.dart';
part 'cycle_model.g.dart';

/// App-level model for a complete menstrual cycle.
///
/// Wraps the raw [CyclesTable] row data with computed phase information
/// and associated period logs. Used by providers and UI — NOT persisted
/// directly (Drift-generated [Cycle] row class handles persistence).
@freezed
abstract class CycleModel with _$CycleModel {
  const factory CycleModel({
    /// Database row ID from cycles table.
    required int id,

    /// First day of the cycle (first day of period).
    required DateTime startDate,

    /// Last day of the cycle (day before next period starts). Null while ongoing.
    DateTime? endDate,

    /// Computed cycle length in days. Null until cycle is closed.
    int? cycleLength,

    /// Number of period days in this cycle. Null until cycle is closed.
    int? periodLength,

    /// Whether this cycle row was predicted (not user-confirmed).
    @Default(false) bool isPredicted,

    /// Period logs belonging to this cycle.
    @Default([]) List<PeriodLogModel> periodLogs,

    /// Current phase of this cycle (computed by PhaseCalculator).
    CyclePhase? currentPhase,

    /// Day number within this cycle (1-based).
    int? cycleDay,

    /// When this row was first inserted.
    required DateTime createdAt,

    /// When this row was last updated.
    required DateTime updatedAt,
  }) = _CycleModel;

  factory CycleModel.fromJson(Map<String, dynamic> json) =>
      _$CycleModelFromJson(json);
}
