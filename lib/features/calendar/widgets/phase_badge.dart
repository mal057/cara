import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/phase_tips.dart';
import '../../../core/enums/cycle_phase.dart';
import '../../../providers/calendar_providers.dart';
import '../../../providers/cycle_providers.dart';
import '../../../services/cycle/phase_calculator.dart';

/// Displays the current cycle phase with name, day number, and a daily tip.
///
/// Reads the current cycle from [currentCycleProvider] and the selected
/// date from [selectedDateProvider]. Renders a pill-shaped card tinted with
/// the phase colour from [PhaseCalculator.getPhaseColor].
///
/// Tips rotate based on [cycleDay % tip_count] so they change each day
/// without network access.
class PhaseBadge extends ConsumerWidget {
  const PhaseBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycleAsync = ref.watch(currentCycleProvider);

    return cycleAsync.when(
      loading: () => const _PhaseBadgeSkeleton(),
      error: (_, __) => const SizedBox.shrink(),
      data: (cycle) {
        if (cycle == null) return const _NoCycleChip();

        final today = DateTime.now();
        final cycleDay =
            today.difference(cycle.startDate.startOfDay).inDays + 1;
        final phase = cycle.currentPhase ?? CyclePhase.menstrual;
        final phaseColor = PhaseCalculator.getPhaseColor(phase);
        final tips = kPhaseTips[phase] ?? const [];
        final tip = tips.isEmpty
            ? null
            : tips[(cycleDay - 1).clamp(0, tips.length - 1) % tips.length];

        return _PhaseBadgeCard(
          phase: phase,
          cycleDay: cycleDay.clamp(1, 60),
          phaseColor: phaseColor,
          tip: tip,
        );
      },
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
  });

  final CyclePhase phase;
  final int cycleDay;
  final Color phaseColor;
  final String? tip;

  @override
  Widget build(BuildContext context) {
    final bgColor = phaseColor.withAlpha(26);
    final borderColor = phaseColor.withAlpha(77);

    return Semantics(
      label: '${phase.description} day $cycleDay',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.space16,
          vertical: AppSizes.space12,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          border: Border.all(color: borderColor, width: 1),
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
                // Phase name
                Text(
                  phase.description,
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
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
  const _NoCycleChip();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Start logging to see your cycle phases',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.space16,
          vertical: AppSizes.space12,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(13),
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          border: Border.all(
            color: AppColors.primary.withAlpha(51),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Icon(
                Icons.info_outline,
                size: AppSizes.iconSmall,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSizes.space8),
            Text(
              'Start logging to see your cycle phases',
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _PhaseBadgeSkeleton
// ---------------------------------------------------------------------------

class _PhaseBadgeSkeleton extends StatelessWidget {
  const _PhaseBadgeSkeleton();

  @override
  Widget build(BuildContext context) {
    // Loading skeleton is purely decorative; exclude from semantics tree
    // to avoid an empty/unhelpful announcement.
    return ExcludeSemantics(
      child: Container(
        width: double.infinity,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DateTime startOfDay extension (local, avoids re-importing)
// ---------------------------------------------------------------------------

extension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
}
