import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/flow_intensity.dart';

/// A three-button selector for choosing flow intensity: Light, Medium, Heavy.
///
/// Each option is rendered as a labelled icon button. The selected option is
/// highlighted with the primary colour; unselected options use a subtle border.
/// Tapping any option triggers [HapticFeedback.selectionClick] and calls
/// [onChanged] with the new [FlowIntensity] value.
class FlowSelector extends StatelessWidget {
  const FlowSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  /// The currently-selected flow intensity.
  final FlowIntensity selected;

  /// Called when the user taps a different intensity option.
  final ValueChanged<FlowIntensity> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IntensityOption(
          intensity: FlowIntensity.light,
          icon: Icons.water_drop_outlined,
          selected: selected == FlowIntensity.light,
          onTap: () => _select(FlowIntensity.light),
        ),
        const SizedBox(width: AppSizes.space8),
        _IntensityOption(
          intensity: FlowIntensity.medium,
          icon: Icons.water_drop,
          selected: selected == FlowIntensity.medium,
          onTap: () => _select(FlowIntensity.medium),
        ),
        const SizedBox(width: AppSizes.space8),
        _IntensityOption(
          intensity: FlowIntensity.heavy,
          icon: Icons.water,
          selected: selected == FlowIntensity.heavy,
          onTap: () => _select(FlowIntensity.heavy),
        ),
      ],
    );
  }

  void _select(FlowIntensity intensity) {
    HapticFeedback.selectionClick();
    onChanged(intensity);
  }
}

class _IntensityOption extends StatelessWidget {
  const _IntensityOption({
    required this.intensity,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final FlowIntensity intensity;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.menstrual;
    final Color borderColor =
        selected ? activeColor : AppColors.inputBorder;
    final Color bgColor =
        selected ? activeColor.withAlpha(26) : Colors.transparent;
    final Color contentColor =
        selected ? activeColor : AppColors.textSecondary;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSizes.animFast),
          curve: Curves.easeInOut,
          constraints: const BoxConstraints(
            minHeight: AppSizes.touchTarget,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.space8,
            horizontal: AppSizes.space4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppSizes.iconMedium, color: contentColor),
              const SizedBox(height: AppSizes.tinyGap),
              Text(
                intensity.displayName,
                style: AppTypography.chip.copyWith(color: contentColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
