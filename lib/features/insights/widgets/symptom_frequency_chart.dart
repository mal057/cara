import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/symptom_stat_model.dart';

/// Horizontal bar chart showing the top symptoms by occurrence count.
///
/// No third-party charting library -- bars are plain [AnimatedContainer]
/// widgets that fill proportionally to the highest-count symptom.
class SymptomFrequencyChart extends StatelessWidget {
  const SymptomFrequencyChart({super.key, required this.stats, this.maxItems = 8});

  final List<SymptomStat> stats;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) return _buildEmpty();
    final display = stats.take(maxItems).toList();
    final maxCount = display.map((s) => s.occurrenceCount).reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity, padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        boxShadow: [BoxShadow(color: AppColors.textPrimary.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Symptom Patterns', style: AppTypography.heading3),
          const SizedBox(height: AppSizes.space4),
          Text('Last 3 months', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSizes.space16),
          ...display.asMap().entries.map((e) {
            final i = e.key; final stat = e.value;
            final fraction = maxCount > 0 ? stat.occurrenceCount / maxCount : 0.0;
            return Padding(
              padding: EdgeInsets.only(bottom: i == display.length - 1 ? 0 : AppSizes.space12),
              child: _SymptomBar(name: stat.symptomName, count: stat.occurrenceCount, fraction: fraction, avgSeverity: stat.averageSeverity),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        boxShadow: [BoxShadow(color: AppColors.textPrimary.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Symptom Patterns', style: AppTypography.heading3),
        const SizedBox(height: AppSizes.space16),
        Row(children: [
          Icon(Icons.bar_chart_rounded, size: AppSizes.iconMedium, color: AppColors.primary.withAlpha(102)),
          const SizedBox(width: AppSizes.space12),
          Expanded(child: Text('Log symptoms to see patterns here.', style: AppTypography.body2.copyWith(color: AppColors.textSecondary))),
        ]),
      ]),
    );
  }
}

class _SymptomBar extends StatelessWidget {
  const _SymptomBar({required this.name, required this.count, required this.fraction, required this.avgSeverity});

  final String name;
  final int count;
  final double fraction;
  final double avgSeverity;

  Color get _barColor {
    if (avgSeverity >= 2.5) return AppColors.menstrual;
    if (avgSeverity >= 1.5) return AppColors.ovulatory;
    return AppColors.follicular;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name logged $count times',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(name, style: AppTypography.body2.copyWith(color: AppColors.textPrimary)),
            Text('$count', style: AppTypography.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: AppSizes.space4),
          LayoutBuilder(builder: (context, constraints) {
            final barWidth = constraints.maxWidth * fraction.clamp(0.0, 1.0);
            return Stack(children: [
              Container(height: 8, width: constraints.maxWidth,
                decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(AppSizes.radiusPill))),
              AnimatedContainer(duration: const Duration(milliseconds: AppSizes.animSlow),
                height: 8, width: barWidth,
                decoration: BoxDecoration(color: _barColor, borderRadius: BorderRadius.circular(AppSizes.radiusPill))),
            ]);
          }),
        ],
      ),
    );
  }
}
