import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/cycle_stats_model.dart';

/// Displays aggregate cycle statistics: average cycle length, average period
/// length, cycle range, and a regularity badge.
///
/// Requires a [CycleStatsModel] computed by [CyclePredictionService.getStats].
/// Shown in [InsightsScreen] below [PhaseInfoCard].
class CycleSummaryCard extends StatelessWidget {
  const CycleSummaryCard({
    super.key,
    required this.stats,
  });

  /// The aggregated cycle statistics to display.
  final CycleStatsModel stats;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cycle summary',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withAlpha(13),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cycle Summary', style: AppTypography.heading3),
                _RegularityBadge(isIrregular: stats.isIrregular),
              ],
            ),
            const SizedBox(height: AppSizes.space16),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Avg Cycle',
                    value: '${stats.avgCycleLength.round()} days',
                    icon: Icons.loop_rounded,
                    iconColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSizes.space12),
                Expanded(
                  child: _StatTile(
                    label: 'Avg Period',
                    value: '${stats.avgPeriodLength.round()} days',
                    icon: Icons.water_drop_rounded,
                    iconColor: AppColors.menstrual,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.space12),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Range',
                    value: '${stats.minCycleLength}–${stats.maxCycleLength} days',
                    icon: Icons.swap_horiz_rounded,
                    iconColor: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: AppSizes.space12),
                Expanded(
                  child: _StatTile(
                    label: 'Cycles Logged',
                    value: '${stats.totalCycles}',
                    icon: Icons.calendar_today_rounded,
                    iconColor: AppColors.luteal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat tile
// ---------------------------------------------------------------------------

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: AppSizes.iconSmall, color: iconColor),
              const SizedBox(width: AppSizes.space4),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.space4),
          Text(
            value,
            style: AppTypography.body1.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Regularity badge
// ---------------------------------------------------------------------------

class _RegularityBadge extends StatelessWidget {
  const _RegularityBadge({required this.isIrregular});

  final bool isIrregular;

  @override
  Widget build(BuildContext context) {
    final color = isIrregular ? AppColors.ovulatory : AppColors.success;
    final label = isIrregular ? 'Irregular' : 'Regular';
    final icon = isIrregular ? Icons.sync_problem_rounded : Icons.check_circle_rounded;

    return Semantics(
      label: '$label cycle pattern',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.space8,
          vertical: AppSizes.space4,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          border: Border.all(color: color.withAlpha(77)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: AppSizes.space4),
            Text(
              label,
              style: AppTypography.chip.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
