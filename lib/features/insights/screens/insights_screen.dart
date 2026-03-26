import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/export_range.dart';
import '../../../features/shared/widgets/sola_loading.dart';
import '../../../features/shared/widgets/sola_scaffold.dart';
import '../../../providers/cycle_providers.dart';
import '../../../providers/symptom_providers.dart';
import '../widgets/cycle_length_chart.dart';
import '../widgets/cycle_summary_card.dart';
import '../widgets/phase_info_card.dart';
import '../widgets/prediction_card.dart';
import '../widgets/symptom_frequency_chart.dart';

/// Insights tab: cycle phase info, stats, predictions, and symptom patterns.
///
/// Scrollable column of cards. Pull-to-refresh invalidates all providers to
/// recompute stats and predictions from fresh DB data.
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(cycleStatsProvider);
    final predAsync = ref.watch(predictionProvider);
    final cyclesAsync = ref.watch(completedCyclesProvider);
    final sympAsync = ref.watch(symptomStatsProvider(ExportRange.threeMonths));

    return SolaScaffold(
      title: 'Insights',
      padding: EdgeInsets.zero,
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(cycleStatsProvider);
          ref.invalidate(predictionProvider);
          ref.invalidate(completedCyclesProvider);
          ref.invalidate(symptomStatsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding, vertical: AppSizes.space16),
          children: [
            const PhaseInfoCard(),
            const SizedBox(height: AppSizes.sectionGap),
            statsAsync.when(
              loading: () => const SolaLoading.skeleton(rows: 1, rowHeight: 140),
              error: (e, _) => _ErrorCard(message: 'Could not load cycle stats.'),
              data: (stats) => stats != null
                  ? CycleSummaryCard(stats: stats)
                  : _EmptyCard(icon: Icons.loop_rounded, message: 'Log your first period to see cycle stats.'),
            ),
            const SizedBox(height: AppSizes.sectionGap),
            predAsync.when(
              loading: () => const SolaLoading.skeleton(rows: 1, rowHeight: 180),
              error: (e, _) => _ErrorCard(message: 'Could not load predictions.'),
              data: (prediction) => PredictionCard(
                prediction: prediction,
                completedCycleCount: cyclesAsync.valueOrNull?.length ?? 0,
              ),
            ),
            const SizedBox(height: AppSizes.sectionGap),
            sympAsync.when(
              loading: () => const SolaLoading.skeleton(rows: 1, rowHeight: 200),
              error: (e, _) => _ErrorCard(message: 'Could not load symptom data.'),
              data: (stats) {
                final sorted = List.of(stats)..sort((a, b) => b.occurrenceCount.compareTo(a.occurrenceCount));
                return SymptomFrequencyChart(stats: sorted);
              },
            ),
            const SizedBox(height: AppSizes.sectionGap),
            cyclesAsync.when(
              loading: () => const SolaLoading.skeleton(rows: 1, rowHeight: 180),
              error: (e, _) => _ErrorCard(message: 'Could not load cycle history.'),
              data: (cycles) => CycleLengthChart(completedCycles: cycles),
            ),
            const SizedBox(height: AppSizes.space32),
          ],
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.message});
  final IconData icon; final String message;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity, padding: const EdgeInsets.all(AppSizes.cardPadding),
    decoration: BoxDecoration(
      color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      boxShadow: [BoxShadow(color: AppColors.textPrimary.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: Row(children: [
      Icon(icon, size: AppSizes.iconMedium, color: AppColors.primary.withAlpha(102)),
      const SizedBox(width: AppSizes.space12),
      Expanded(child: Text(message, style: AppTypography.body2.copyWith(color: AppColors.textSecondary))),
    ]),
  );
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity, padding: const EdgeInsets.all(AppSizes.cardPadding),
    decoration: BoxDecoration(
      color: AppColors.error.withAlpha(13), borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      border: Border.all(color: AppColors.error.withAlpha(51)),
    ),
    child: Row(children: [
      Icon(Icons.error_outline_rounded, size: AppSizes.iconSmall, color: AppColors.error),
      const SizedBox(width: AppSizes.space8),
      Expanded(child: Text(message, style: AppTypography.body2.copyWith(color: AppColors.error))),
    ]),
  );
}
