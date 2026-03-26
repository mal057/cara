import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/enums/cycle_phase.dart';

/// Pure, stateless helper for determining which [CyclePhase] a given cycle day
/// belongs to, and for computing ovulation / fertile-window estimates.
///
/// All methods are static.  This class holds no state and performs no I/O.
///
/// ## Phase boundaries (1-indexed cycle days)
///
/// | Phase      | Day range                                     |
/// |------------|-----------------------------------------------|
/// | Menstrual  | 1 … periodLength                              |
/// | Follicular | periodLength + 1 … ovulationDay - 2          |
/// | Ovulatory  | ovulationDay - 1 … ovulationDay + 1 (3 days) |
/// | Luteal     | ovulationDay + 2 … cycleLength                |
///
/// where `ovulationDay = cycleLength - 14`.
abstract class PhaseCalculator {
  PhaseCalculator._();

  // ---------------------------------------------------------------------------
  // Core pure functions (blueprint contract)
  // ---------------------------------------------------------------------------

  /// Returns the [CyclePhase] for a given 1-indexed [cycleDay].
  ///
  /// [cycleDay] is clamped to [1, cycleLength] before evaluation.
  ///
  /// Phase boundaries:
  /// - **Menstrual**: days 1 – [periodLength]
  /// - **Follicular**: days [periodLength]+1 – ovulationDay-2
  /// - **Ovulatory**: days ovulationDay-1 – ovulationDay+1
  /// - **Luteal**: days ovulationDay+2 – [cycleLength]
  static CyclePhase calculatePhaseForDay(
    int cycleDay,
    int periodLength,
    int cycleLength,
  ) {
    assert(periodLength >= 1, 'periodLength must be at least 1');
    assert(cycleLength > periodLength, 'cycleLength must exceed periodLength');

    // Clamp to valid range.
    final day = cycleDay.clamp(1, cycleLength);

    final ovDay = getOvulationDay(cycleLength);

    if (day <= periodLength) {
      return CyclePhase.menstrual;
    }

    if (day >= ovDay - 1 && day <= ovDay + 1) {
      return CyclePhase.ovulatory;
    }

    if (day > ovDay + 1) {
      return CyclePhase.luteal;
    }

    // periodLength < day < ovDay - 1
    return CyclePhase.follicular;
  }

  /// Returns the estimated ovulation day (1-indexed) within a cycle.
  ///
  /// Calculated as `cycleLength - 14` because the luteal phase is relatively
  /// constant at approximately 14 days across individuals.
  static int getOvulationDay(int cycleLength) {
    assert(cycleLength > 14, 'cycleLength must be greater than 14');
    return cycleLength - 14;
  }

  /// Returns the inclusive fertile window as a `(startDay, endDay)` record.
  ///
  /// The fertile window spans from five days before ovulation through the day
  /// after ovulation, giving a 7-day window:
  /// `ovulationDay - 5` to `ovulationDay + 1`.
  ///
  /// [ovulationDay] should be obtained via [getOvulationDay].
  static (int, int) getFertileWindow(int ovulationDay) {
    assert(ovulationDay >= 6, 'ovulationDay must be at least 6 to allow a 5-day lead');
    return (ovulationDay - 5, ovulationDay + 1);
  }

  // ---------------------------------------------------------------------------
  // Additional helpers (architecture spec — ned-flutter.md §5.2)
  // ---------------------------------------------------------------------------

  /// Returns the inclusive `(startDay, endDay)` range for the given [phase]
  /// within a cycle described by [periodLength] and [cycleLength].
  ///
  /// Useful for iterating over all days that belong to a specific phase.
  static (int, int) getPhaseDayRange(
    CyclePhase phase,
    int periodLength,
    int cycleLength,
  ) {
    assert(periodLength >= 1, 'periodLength must be at least 1');
    assert(cycleLength > periodLength, 'cycleLength must exceed periodLength');

    final ovDay = getOvulationDay(cycleLength);

    return switch (phase) {
      CyclePhase.menstrual => (1, periodLength),
      CyclePhase.follicular => (periodLength + 1, ovDay - 2),
      CyclePhase.ovulatory => (ovDay - 1, ovDay + 1),
      CyclePhase.luteal => (ovDay + 2, cycleLength),
    };
  }

  /// Returns the solid (confirmed) display [Color] for [phase] using
  /// [AppColors] constants.
  static Color getPhaseColor(CyclePhase phase) {
    return switch (phase) {
      CyclePhase.menstrual => AppColors.menstrual,
      CyclePhase.follicular => AppColors.follicular,
      CyclePhase.ovulatory => AppColors.ovulatory,
      CyclePhase.luteal => AppColors.luteal,
    };
  }

  /// Returns the predicted (lighter) display [Color] for [phase] using
  /// [AppColors] constants.
  ///
  /// Use this variant when rendering days that fall within a predicted
  /// (not yet confirmed) cycle.
  static Color getPhaseColorPredicted(CyclePhase phase) {
    return switch (phase) {
      CyclePhase.menstrual => AppColors.menstrualPredicted,
      CyclePhase.follicular => AppColors.follicularPredicted,
      CyclePhase.ovulatory => AppColors.ovulatoryPredicted,
      CyclePhase.luteal => AppColors.lutealPredicted,
    };
  }
}
