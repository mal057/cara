import 'dart:async';

import '../../core/utils/cycle_utils.dart';
import '../../data/models/cycle_model.dart';
import '../../data/models/cycle_prediction_model.dart';
import '../../data/models/cycle_stats_model.dart';
import 'phase_calculator.dart';

/// Pure prediction engine for menstrual cycle forecasting.
///
/// All public methods are side-effect-free: they accept data as parameters and
/// return results - no database access, no state mutation.
///
/// The single stateful concern is [recalculate], which is deliberately
/// debounced by 5 seconds (Karla Note 6) so that rapid successive calls (e.g.
/// the user logging multiple period days in a row) collapse into one
/// notification-reschedule operation.
class CyclePredictionService {
  /// The callback invoked after the debounce settles.
  ///
  /// Callers (providers / notification service) supply this to act on a fresh
  /// prediction without CyclePredictionService needing a database reference.
  final Future<void> Function()? _onRecalculate;

  Timer? _debounceTimer;

  CyclePredictionService({Future<void> Function()? onRecalculate})
      : _onRecalculate = onRecalculate;

  // ---------------------------------------------------------------------------
  // Public pure API
  // ---------------------------------------------------------------------------

  /// Returns a [CyclePredictionModel] for the next cycle, or null if
  /// [completedCycles] contains fewer than 3 completed (non-null cycleLength)
  /// entries.
  ///
  /// Algorithm:
  /// 1. Extract cycle lengths from the most-recent completed cycles.
  /// 2. Compute predicted length via [CycleUtils.predictNextLength] (weighted
  ///    moving average with weights 3.0, 2.5, 2.0, 1.5, 1.0, 0.5).
  /// 3. Derive ovulation day -> fertile window via [PhaseCalculator].
  /// 4. Compute a confidence score in [0.0, 1.0] from cycle count and
  ///    std-deviation of lengths (lower variance = higher confidence).
  CyclePredictionModel? predictNextCycle(List<CycleModel> completedCycles) {
    final lengths = _completedLengths(completedCycles);
    if (lengths.length < 3) return null;

    final predictedLengthDouble = CycleUtils.predictNextLength(lengths)!;
    final predictedLength = predictedLengthDouble.round();

    // Last completed cycle end date anchors the prediction.
    final lastCycle = _lastCompleted(completedCycles)!;
    final lastEnd = lastCycle.endDate ?? lastCycle.startDate;
    final predictedStart = lastEnd.add(const Duration(days: 1));

    // Average period length across completed cycles (fallback to 5 if unknown).
    final avgPeriodLength = _averagePeriodLength(completedCycles);
    final predictedEnd = predictedStart.add(
      Duration(days: (avgPeriodLength - 1).round()),
    );

    // Ovulation and fertile window (from PhaseCalculator).
    // Guard: predictedLength must be > 14 for getOvulationDay to be valid.
    final safeCycleLength = predictedLength > 14 ? predictedLength : 28;
    final ovulationDay = PhaseCalculator.getOvulationDay(safeCycleLength);
    final fertileWindow = PhaseCalculator.getFertileWindow(ovulationDay);

    final fertileWindowStart =
        predictedStart.add(Duration(days: fertileWindow.$1 - 1));
    final fertileWindowEnd =
        predictedStart.add(Duration(days: fertileWindow.$2 - 1));

    final irregular = CycleUtils.isIrregular(lengths);
    final confidence = _calculateConfidence(lengths);

    return CyclePredictionModel(
      predictedStart: predictedStart,
      predictedEnd: predictedEnd,
      fertileWindowStart: fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd,
      confidence: confidence,
      isIrregular: irregular,
    );
  }

  /// Generates predictions for the next [count] cycles.
  ///
  /// Each successive prediction treats the prior predicted cycle as a
  /// completed cycle so that the weighted moving average rolls forward
  /// naturally. Returns an empty list when [completedCycles] has fewer than 3
  /// completed entries.
  List<CyclePredictionModel> predictMultipleCycles(
    List<CycleModel> completedCycles,
    int count,
  ) {
    assert(count >= 1, 'count must be at least 1');

    final lengths = _completedLengths(completedCycles);
    if (lengths.length < 3) return [];

    final results = <CyclePredictionModel>[];

    // Rolling state: the list of cycle lengths (we append predicted lengths).
    final rollingLengths = List<double>.from(lengths);

    // Start date anchor for the first prediction.
    final lastCompleted = _lastCompleted(completedCycles)!;
    DateTime anchorEnd = lastCompleted.endDate ?? lastCompleted.startDate;

    final avgPeriodLength = _averagePeriodLength(completedCycles);

    for (int i = 0; i < count; i++) {
      final predictedLengthDouble =
          CycleUtils.predictNextLength(rollingLengths)!;
      final predictedLength = predictedLengthDouble.round();

      final predictedStart = anchorEnd.add(const Duration(days: 1));
      final predictedEnd = predictedStart.add(
        Duration(days: (avgPeriodLength - 1).round()),
      );

      final safeCycleLength = predictedLength > 14 ? predictedLength : 28;
      final ovulationDay = PhaseCalculator.getOvulationDay(safeCycleLength);
      final fertileWindow = PhaseCalculator.getFertileWindow(ovulationDay);

      final fertileWindowStart =
          predictedStart.add(Duration(days: fertileWindow.$1 - 1));
      final fertileWindowEnd =
          predictedStart.add(Duration(days: fertileWindow.$2 - 1));

      final irregular = CycleUtils.isIrregular(rollingLengths);
      final confidence = _calculateConfidence(rollingLengths);

      results.add(CyclePredictionModel(
        predictedStart: predictedStart,
        predictedEnd: predictedEnd,
        fertileWindowStart: fertileWindowStart,
        fertileWindowEnd: fertileWindowEnd,
        confidence: confidence,
        isIrregular: irregular,
      ));

      // Advance the anchor to the predicted cycle end.
      anchorEnd = predictedStart.add(Duration(days: predictedLength - 1));
      rollingLengths.add(predictedLengthDouble);
    }

    return results;
  }

  /// Returns true when the standard deviation of completed cycle lengths
  /// exceeds 5 days, indicating irregular cycles.
  ///
  /// Delegates entirely to [CycleUtils.isIrregular].
  bool isIrregular(List<CycleModel> completedCycles) {
    final lengths = _completedLengths(completedCycles);
    return CycleUtils.isIrregular(lengths);
  }

  /// Computes aggregate statistics over [completedCycles].
  ///
  /// Returns a [CycleStatsModel] or null when no completed cycles exist.
  CycleStatsModel? getStats(List<CycleModel> completedCycles) {
    final cycles = _onlyCompleted(completedCycles);
    if (cycles.isEmpty) return null;

    final lengths = cycles
        .map((c) => c.cycleLength!.toDouble())
        .toList(growable: false);

    final periodLengths = cycles
        .where((c) => c.periodLength != null)
        .map((c) => c.periodLength!.toDouble())
        .toList(growable: false);

    // Plain mean for summary stats (weighted average is reserved for prediction).
    final avgCycleLength = lengths.reduce((a, b) => a + b) / lengths.length;

    final avgPeriodLength = periodLengths.isNotEmpty
        ? periodLengths.reduce((a, b) => a + b) / periodLengths.length
        : 5.0; // sensible default when no period lengths recorded

    final minCycleLength =
        lengths.map((l) => l.round()).reduce((a, b) => a < b ? a : b);
    final maxCycleLength =
        lengths.map((l) => l.round()).reduce((a, b) => a > b ? a : b);

    return CycleStatsModel(
      avgCycleLength: avgCycleLength,
      avgPeriodLength: avgPeriodLength,
      minCycleLength: minCycleLength,
      maxCycleLength: maxCycleLength,
      totalCycles: cycles.length,
      isIrregular: CycleUtils.isIrregular(lengths),
    );
  }

  // ---------------------------------------------------------------------------
  // Debounced recalculate (Karla Note 6)
  // ---------------------------------------------------------------------------

  /// Triggers a prediction recalculation after a 5-second debounce.
  ///
  /// Multiple rapid calls (e.g. user logging several period days in quick
  /// succession) collapse into a single recalculation that fires 5 seconds
  /// after the last call. This prevents unnecessary notification rescheduling.
  ///
  /// The actual work is performed by the [onRecalculate] callback supplied at
  /// construction time.
  Future<void> recalculate() async {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 5), () async {
      if (_onRecalculate != null) {
        await _onRecalculate();
      }
    });
  }

  /// Cancels any pending debounce timer.
  ///
  /// Call this when the service is no longer needed (e.g. in a provider
  /// dispose callback) to avoid a dangling timer.
  void dispose() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Returns only the entries from [cycles] that have a non-null [cycleLength]
  /// and [endDate] - i.e. truly completed cycles, not the currently-ongoing one.
  List<CycleModel> _onlyCompleted(List<CycleModel> cycles) => cycles
      .where((c) => c.cycleLength != null && c.endDate != null)
      .toList(growable: false);

  /// Extracts cycle lengths as doubles from completed cycles, oldest-first.
  List<double> _completedLengths(List<CycleModel> cycles) =>
      _onlyCompleted(cycles)
          .map((c) => c.cycleLength!.toDouble())
          .toList(growable: false);

  /// Returns the most recently completed cycle, or null if none.
  CycleModel? _lastCompleted(List<CycleModel> cycles) {
    final completed = _onlyCompleted(cycles);
    if (completed.isEmpty) return null;
    return completed.last;
  }

  /// Average period length across completed cycles that have a [periodLength].
  /// Falls back to 5.0 days when none have been recorded.
  double _averagePeriodLength(List<CycleModel> cycles) {
    final periodLengths = _onlyCompleted(cycles)
        .where((c) => c.periodLength != null)
        .map((c) => c.periodLength!.toDouble())
        .toList(growable: false);
    if (periodLengths.isEmpty) return 5.0;
    return periodLengths.reduce((a, b) => a + b) / periodLengths.length;
  }

  /// Confidence score in [0.0, 1.0].
  ///
  /// Formula:
  /// - Count contribution: 3 cycles -> 0.0, 12+ cycles -> 0.5 (linear scale).
  /// - Regularity contribution: std-dev 0 -> +0.5, std-dev 10+ -> +0.0.
  /// - Result clamped to [0.0, 1.0].
  double _calculateConfidence(List<double> lengths) {
    if (lengths.length < 3) return 0.0;

    // Count contribution: 3 cycles -> 0.0, 12+ cycles -> 0.5.
    final countContribution =
        ((lengths.length - 3) / 9.0).clamp(0.0, 0.5);

    // Regularity contribution: stdDev 0 -> 0.5, stdDev 10+ -> 0.0.
    final sd = CycleUtils.stdDev(lengths);
    final regularityContribution = (1.0 - (sd / 10.0)).clamp(0.0, 1.0) * 0.5;

    return (countContribution + regularityContribution).clamp(0.0, 1.0);
  }
}
