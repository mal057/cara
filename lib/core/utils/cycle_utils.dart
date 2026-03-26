import 'dart:math' as math;

/// Statistical utility functions for cycle prediction calculations.
class CycleUtils {
  CycleUtils._();

  // ---------------------------------------------------------------------------
  // Statistical helpers
  // ---------------------------------------------------------------------------

  /// Returns the population standard deviation of [values].
  ///
  /// Returns `0.0` when [values] has fewer than 2 elements.
  static double stdDev(List<double> values) {
    if (values.length < 2) return 0.0;
    final mean = _mean(values);
    final variance =
        values.map((v) => math.pow(v - mean, 2).toDouble()).reduce((a, b) => a + b) /
            values.length;
    return math.sqrt(variance);
  }

  /// Returns the weighted average of [values] using [weights].
  ///
  /// [values] and [weights] must have the same length and contain at least
  /// one element.  Weights need not sum to 1; they are normalised internally.
  ///
  /// Throws [ArgumentError] if the lists are empty or have different lengths.
  static double weightedAverage(List<double> values, List<double> weights) {
    if (values.isEmpty) {
      throw ArgumentError('values must not be empty');
    }
    if (values.length != weights.length) {
      throw ArgumentError(
        'values and weights must have the same length '
        '(got ${values.length} vs ${weights.length})',
      );
    }

    double weightedSum = 0.0;
    double totalWeight = 0.0;
    for (int i = 0; i < values.length; i++) {
      weightedSum += values[i] * weights[i];
      totalWeight += weights[i];
    }

    if (totalWeight == 0.0) {
      throw ArgumentError('weights must not all be zero');
    }

    return weightedSum / totalWeight;
  }

  // ---------------------------------------------------------------------------
  // Cycle-specific helpers
  // ---------------------------------------------------------------------------

  /// Returns true when the standard deviation of [cycleLengths] exceeds
  /// [thresholdDays] (default 5), indicating an irregular cycle.
  static bool isIrregular(
    List<double> cycleLengths, {
    double thresholdDays = 5.0,
  }) {
    if (cycleLengths.length < 3) return false;
    return stdDev(cycleLengths) > thresholdDays;
  }

  /// Computes the predicted next cycle length using a weighted moving average.
  ///
  /// The most-recent cycle receives the highest weight.  At most the last
  /// 6 cycles are used, with weights [3.0, 2.5, 2.0, 1.5, 1.0, 0.5] from
  /// newest to oldest.
  ///
  /// Returns `null` if [cycleLengths] has fewer than 3 values.
  static double? predictNextLength(List<double> cycleLengths) {
    if (cycleLengths.length < 3) return null;

    const allWeights = [3.0, 2.5, 2.0, 1.5, 1.0, 0.5];
    // Take the last 6 (newest are at the end of the list).
    final take = math.min(cycleLengths.length, allWeights.length);
    final recent = cycleLengths.sublist(cycleLengths.length - take);
    // Reverse so index 0 = newest.
    final reversed = recent.reversed.toList();
    final weights = allWeights.sublist(0, take);

    return weightedAverage(reversed, weights);
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  static double _mean(List<double> values) =>
      values.reduce((a, b) => a + b) / values.length;
}
