import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../shared/widgets/cara_scaffold.dart';
import '../widgets/cycle_calendar.dart';
import '../widgets/phase_badge.dart';

/// The Calendar tab screen - the home screen of Cara.
///
/// Layout (top to bottom):
/// 1. [CycleCalendar] - full-width TableCalendar with phase-coloured cells
/// 2. [PhaseBadge] - current phase name, day number, and wellness tip
///
/// Day selection opens [DayDetailSheet] (initiated inside [CycleCalendar]).
/// Month swipes pre-fetch adjacent months via [MonthDataCacheNotifier].
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CaraScaffold(
      // Full-bleed calendar - override default horizontal padding
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calendar fills available width; no horizontal padding
            const CycleCalendar(),
            // Phase colour legend below calendar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding,
                vertical: AppSizes.space8,
              ),
              child: const _PhaseLegend(),
            ),
            // Phase badge below legend with standard page padding
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding,
              ).copyWith(bottom: AppSizes.space12),
              child: const PhaseBadge(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _PhaseLegend
// ---------------------------------------------------------------------------

class _PhaseLegend extends StatelessWidget {
  const _PhaseLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space8,
        vertical: AppSizes.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withAlpha(200),
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      child: Wrap(
        spacing: AppSizes.space16,
        runSpacing: AppSizes.space4,
        alignment: WrapAlignment.center,
        children: [
          _legendItem(AppColors.menstrual, 'Period'),
          _legendItem(AppColors.follicular, 'Follicular'),
          _legendItem(AppColors.ovulatory, 'Ovulation'),
          _legendItem(AppColors.luteal, 'Luteal'),
          _predictedLegendItem(),
        ],
      ),
    );
  }

  static Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textPrimary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  static Widget _predictedLegendItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.lutealPredicted,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.textSecondary, width: 0.5),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'Predicted',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
