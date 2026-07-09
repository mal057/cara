import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_stats_model.freezed.dart';
part 'cycle_stats_model.g.dart';

/// App-level model for computed aggregate cycle statistics.
///
/// Produced by [CyclePredictionService.getStats] from a list of completed
/// cycles. Displayed on the Insights screen via [CycleSummaryCard].
@freezed
abstract class CycleStatsModel with _$CycleStatsModel {
  const factory CycleStatsModel({
    /// Weighted average cycle length in days across all completed cycles.
    required double avgCycleLength,

    /// Weighted average period length in days across all completed cycles.
    required double avgPeriodLength,

    /// Shortest recorded cycle length in days.
    required int minCycleLength,

    /// Longest recorded cycle length in days.
    required int maxCycleLength,

    /// Total number of completed cycles in the history.
    required int totalCycles,

    /// True if cycle history shows high variability (std_dev > 5 days).
    @Default(false) bool isIrregular,
  }) = _CycleStatsModel;

  factory CycleStatsModel.fromJson(Map<String, dynamic> json) =>
      _$CycleStatsModelFromJson(json);
}
