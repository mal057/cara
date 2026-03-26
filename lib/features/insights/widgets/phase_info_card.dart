import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/phase_tips.dart';
import '../../../core/enums/cycle_phase.dart';
import '../../../data/models/cycle_model.dart';
import '../../../providers/cycle_providers.dart';
import '../../../services/cycle/phase_calculator.dart';

/// Displays the current cycle phase, phase day, and a phase-appropriate tip.
///
/// Shows a color-coded card matching the current phase (menstrual, follicular,
/// ovulatory, luteal). Tip is selected by cycling through [kPhaseTips] using
/// the current day-of-year as the rotation index so it feels fresh daily.
///
/// Shown at the top of [InsightsScreen].
class PhaseInfoCard extends ConsumerWidget {
  const PhaseInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCycleAsync = ref.watch(currentCycleProvider);

    return currentCycleAsync.when(
      loading: () => _buildSkeleton(),
      error: (_, __) => _buildEmpty(),
      data: (cycle) {
        if (cycle == null) return _buildEmpty();
        return _buildCard(cycle);
      },
    );
  }

  Widget _buildCard(CycleModel cycle) {
    final phase = cycle.currentPhase ?? CyclePhase.follicular;
    final cycleDay = cycle.cycleDay ?? 1;
    final phaseColor = PhaseCalculator.getPhaseColor(phase);
    final tips = kPhaseTips[phase] ?? [];
    final tip = tips.isNotEmpty
        ? tips[DateTime.now().dayOfYear % tips.length]
        : '';

    return Semantics(
      label: '${phase.description}, day $cycleDay of cycle',
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: phaseColor.withAlpha(26),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          border: Border.all(color: phaseColor.withAlpha(77), width: 1.5),
        ),
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: phaseColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.space8),
                Text(
                  phase.description,
                  style: AppTypography.heading3.copyWith(color: phaseColor),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.space8,
                    vertical: AppSizes.space4,
                  ),
                  decoration: BoxDecoration(
                    color: phaseColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                  ),
                  child: Text(
                    'Day $cycleDay',
                    style: AppTypography.chip.copyWith(color: phaseColor),
                  ),
                ),
              ],
            ),
            if (tip.isNotEmpty) ...[
              const SizedBox(height: AppSizes.space12),
              Text(
                tip,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Phase', style: AppTypography.heading3),
          const SizedBox(height: AppSizes.space8),
          Text(
            'Start logging your period to see your current cycle phase.',
            style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Container(
      width: double.infinity,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.divider.withAlpha(102),
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
    );
  }
}

extension on DateTime {
  /// Returns the day of the year (1-indexed).
  int get dayOfYear {
    final startOfYear = DateTime(year, 1, 1);
    return difference(startOfYear).inDays + 1;
  }
}
