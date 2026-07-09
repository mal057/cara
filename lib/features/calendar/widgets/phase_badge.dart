import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/phase_tips.dart';
import '../../../core/enums/cycle_phase.dart';
import '../../../navigation/route_names.dart';
import '../../../providers/calendar_providers.dart';
import '../../../services/cycle/phase_calculator.dart';

/// Displays the cycle phase for the selected calendar date (or today when
/// nothing is selected) with phase name, day number, a daily tip, the
/// formatted selected date, and a "Log this day" action that navigates to
/// the Log tab.
///
/// Reads the selected date from [selectedDateProvider] and its pre-computed
/// day data from [dayDataProvider] — the same data source that powers the
/// calendar cell colours. This guarantees the badge is always consistent
/// with the calendar grid.
///
/// Tips rotate based on [cycleDay % tip_count] so they change each day
/// without network access.
class PhaseBadge extends ConsumerWidget {
  const PhaseBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final dayData = ref.watch(dayDataProvider(selectedDate));

    if (dayData == null || dayData.phase == null) {
      return _NoCycleChip(selectedDate: selectedDate);
    }

    final phase = dayData.phase!;
    final cycleDay = dayData.cycleDay ?? 1;
    final isPredicted = dayData.isPredicted;
    final phaseColor = isPredicted
        ? PhaseCalculator.getPhaseColorPredicted(phase)
        : PhaseCalculator.getPhaseColor(phase);
    final tips = kPhaseTips[phase] ?? const [];
    final tip = tips.isEmpty
        ? null
        : tips[(cycleDay - 1).clamp(0, tips.length - 1) % tips.length];

    return _PhaseBadgeCard(
      phase: phase,
      cycleDay: cycleDay,
      phaseColor: phaseColor,
      tip: tip,
      selectedDate: selectedDate,
      isPredicted: isPredicted,
    );
  }
}

// ---------------------------------------------------------------------------
// _PhaseBadgeCard
// ---------------------------------------------------------------------------

class _PhaseBadgeCard extends StatelessWidget {
  const _PhaseBadgeCard({
    required this.phase,
    required this.cycleDay,
    required this.phaseColor,
    required this.tip,
    required this.selectedDate,
    required this.isPredicted,
  });

  final CyclePhase phase;
  final int cycleDay;
  final Color phaseColor;
  final String? tip;
  final DateTime selectedDate;
  final bool isPredicted;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMM d').format(selectedDate);

    return Semantics(
      label: '${phase.description} day $cycleDay',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.space16,
          vertical: AppSizes.space12,
        ),
        decoration: BoxDecoration(
          color: Color.alphaBlend(phaseColor.withAlpha(30), AppColors.surface),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          border: Border(
            left: BorderSide(color: phaseColor, width: 4),
            top: BorderSide(color: phaseColor.withAlpha(120)),
            right: BorderSide(color: phaseColor.withAlpha(120)),
            bottom: BorderSide(color: phaseColor.withAlpha(120)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Phase colour dot -- decorative, screen reader gets phase name from parent Semantics label
                ExcludeSemantics(
                  child: Container(
                    width: AppSizes.space12,
                    height: AppSizes.space12,
                    decoration: BoxDecoration(
                      color: phaseColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.space8),
                // Phase name + optional Estimated caption
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      phase.description,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isPredicted)
                      Text(
                        'Estimated',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                // Day number badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.space8,
                    vertical: AppSizes.space2,
                  ),
                  decoration: BoxDecoration(
                    color: phaseColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                  ),
                  child: Text(
                    'Day $cycleDay',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            if (tip != null) ...[
              const SizedBox(height: AppSizes.space8),
              Text(
                tip!,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: AppSizes.space12),
            // Action row: date on left, Log this day button on right
            Row(
              children: [
                Text(
                  formattedDate,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => context.go(RouteNames.log),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.space8,
                      vertical: AppSizes.space4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: Text(
                    'Log this day',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  label: Icon(
                    Icons.arrow_forward_rounded,
                    size: AppSizes.space16,
                    color: AppColors.primary,
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
// _NoCycleChip
// ---------------------------------------------------------------------------

class _NoCycleChip extends StatelessWidget {
  const _NoCycleChip({required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, MMM d').format(selectedDate);

    return Semantics(
      label: 'No data logged for $formattedDate',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.space16,
          vertical: AppSizes.space12,
        ),
        decoration: BoxDecoration(
          color: Color.alphaBlend(AppColors.primary.withAlpha(38), AppColors.surface),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          border: Border.all(color: AppColors.primary.withAlpha(120)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  size: AppSizes.iconSmall,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSizes.space8),
                Expanded(
                  child: Text(
                    'No data logged',
                    style: AppTypography.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.space12),
            Row(
              children: [
                Text(
                  formattedDate,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => context.go(RouteNames.log),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.space8,
                      vertical: AppSizes.space4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: Text(
                    'Log this day',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  label: Icon(
                    Icons.arrow_forward_rounded,
                    size: AppSizes.space16,
                    color: AppColors.primary,
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
