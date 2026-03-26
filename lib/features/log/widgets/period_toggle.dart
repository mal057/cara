import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/flow_color.dart';
import '../../../core/enums/flow_intensity.dart';
import 'flow_selector.dart';

/// A toggle widget for period logging with animated flow selectors.
///
/// When [isPeriodDay] is false the widget shows only the toggle row.
/// When true the [FlowSelector] and flow colour circles animate into view
/// via a smooth [AnimatedCrossFade] / [AnimatedSize] transition.
///
/// Haptic feedback: [HapticFeedback.mediumImpact] on period toggle.
class PeriodToggle extends StatelessWidget {
  const PeriodToggle({
    super.key,
    required this.isPeriodDay,
    required this.onToggle,
    required this.selectedIntensity,
    required this.onIntensityChanged,
    required this.selectedColor,
    required this.onColorChanged,
  });

  /// Whether today is marked as a period day.
  final bool isPeriodDay;

  /// Called when the user toggles the period switch.
  final ValueChanged<bool> onToggle;

  /// Currently selected flow intensity — only meaningful when [isPeriodDay].
  final FlowIntensity selectedIntensity;

  /// Called when the user picks a new flow intensity.
  final ValueChanged<FlowIntensity> onIntensityChanged;

  /// Currently selected flow colour — nullable when user has not chosen one.
  final FlowColor? selectedColor;

  /// Called when the user taps a colour circle.
  final ValueChanged<FlowColor?> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Period day', style: AppTypography.body1),
                  const SizedBox(height: AppSizes.space2),
                  Text(
                    isPeriodDay ? 'Tap to turn off' : 'Tap to log today as a period day',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Switch(
              value: isPeriodDay,
              onChanged: (value) {
                HapticFeedback.mediumImpact();
                onToggle(value);
              },
              activeThumbColor: AppColors.menstrual,
              activeTrackColor: AppColors.menstrual.withAlpha(128),
            ),
          ],
        ),
        // Animated reveal of flow selectors
        AnimatedSize(
          duration: const Duration(milliseconds: AppSizes.animStandard),
          curve: Curves.easeInOut,
          child: isPeriodDay
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.space16),
                    Text(
                      'Flow intensity',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.space8),
                    FlowSelector(
                      selected: selectedIntensity,
                      onChanged: onIntensityChanged,
                    ),
                    const SizedBox(height: AppSizes.space16),
                    Text(
                      'Flow colour',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.space8),
                    _FlowColorRow(
                      selected: selectedColor,
                      onChanged: onColorChanged,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// Four colour-circle buttons for selecting flow colour.
class _FlowColorRow extends StatelessWidget {
  const _FlowColorRow({
    required this.selected,
    required this.onChanged,
  });

  final FlowColor? selected;
  final ValueChanged<FlowColor?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FlowColor.values.map((color) {
        final isSelected = selected == color;
        return Padding(
          padding: const EdgeInsets.only(right: AppSizes.space12),
          child: _ColorCircle(
            flowColor: color,
            isSelected: isSelected,
            onTap: () {
              HapticFeedback.selectionClick();
              // Tapping the already-selected color deselects it.
              onChanged(isSelected ? null : color);
            },
          ),
        );
      }).toList(),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  const _ColorCircle({
    required this.flowColor,
    required this.isSelected,
    required this.onTap,
  });

  final FlowColor flowColor;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _displayColor {
    switch (flowColor) {
      case FlowColor.red:
        return const Color(0xFFC0392B);
      case FlowColor.darkRed:
        return const Color(0xFF7B1818);
      case FlowColor.brown:
        return const Color(0xFF795548);
      case FlowColor.pink:
        return const Color(0xFFF48FB1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: flowColor.displayName,
      selected: isSelected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSizes.animFast),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _displayColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? AppColors.textPrimary
                  : Colors.transparent,
              width: 2.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _displayColor.withAlpha(102),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
