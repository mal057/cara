import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A labeled slider widget for selecting a day count in a given range.
///
/// Used in [CycleSetupScreen] for both cycle length (21–45 days) and period
/// length (2–10 days). Emits a light haptic click on every integer step change.
///
/// The slider snaps to integer values and displays the current value alongside
/// a descriptive label.
class CycleLengthSlider extends StatelessWidget {
  const CycleLengthSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.unit = 'days',
  });

  /// Descriptive label shown above the slider (e.g. "Cycle length").
  final String label;

  /// Current integer value.
  final int value;

  /// Minimum selectable value (inclusive).
  final int min;

  /// Maximum selectable value (inclusive).
  final int max;

  /// Called whenever the user changes the slider value.
  final void Function(int value) onChanged;

  /// The unit string appended to the value display (default: 'days').
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTypography.body1.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.space12,
                vertical: AppSizes.space4,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              ),
              child: Text(
                '$value $unit',
                style: AppTypography.body2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.space8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.primary.withAlpha(40),
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withAlpha(30),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            trackHeight: 4,
          ),
          child: Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            onChanged: (rawValue) {
              final newInt = rawValue.round();
              if (newInt != value) {
                HapticFeedback.selectionClick();
                onChanged(newInt);
              }
            },
            semanticFormatterCallback: (v) => '${v.round()} $unit',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$min $unit',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '$max $unit',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
