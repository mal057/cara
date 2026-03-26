import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/cycle_prediction_model.dart';

/// Displays the next predicted period date, fertile window, and confidence bar.
class PredictionCard extends StatelessWidget {
  const PredictionCard({super.key, required this.prediction, required this.completedCycleCount});

  final CyclePredictionModel? prediction;
  final int completedCycleCount;

  static final _dateFormat = DateFormat('EEE, MMM d');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        boxShadow: [BoxShadow(color: AppColors.textPrimary.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: prediction != null ? _buildPredictionContent(prediction!) : _buildInsufficientData(),
    );
  }

  Widget _buildPredictionContent(CyclePredictionModel pred) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final predStart = DateTime(pred.predictedStart.year, pred.predictedStart.month, pred.predictedStart.day);
    final daysUntil = predStart.difference(today).inDays;
    final String daysLabel;
    if (daysUntil < 0) { daysLabel = 'overdue'; }
    else if (daysUntil == 0) { daysLabel = 'today'; }
    else if (daysUntil == 1) { daysLabel = 'in 1 day'; }
    else { daysLabel = 'in $daysUntil days'; }

    return Semantics(
      label: 'Next period predicted ${_dateFormat.format(pred.predictedStart)}, $daysLabel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Period', style: AppTypography.heading3),
              if (pred.isIrregular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.space8, vertical: AppSizes.space4),
                  decoration: BoxDecoration(color: AppColors.ovulatory.withAlpha(26), borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
                  child: Text('Irregular cycle', style: AppTypography.caption.copyWith(color: AppColors.ovulatory)),
                ),
            ],
          ),
          const SizedBox(height: AppSizes.space12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_dateFormat.format(pred.predictedStart), style: AppTypography.heading2.copyWith(color: AppColors.menstrual)),
              const SizedBox(width: AppSizes.space8),
              Padding(padding: const EdgeInsets.only(bottom: 2), child: Text(daysLabel, style: AppTypography.body2.copyWith(color: AppColors.textSecondary))),
            ],
          ),
          const SizedBox(height: AppSizes.space16),
          _FertileWindowRow(start: pred.fertileWindowStart, end: pred.fertileWindowEnd),
          const SizedBox(height: AppSizes.space16),
          _ConfidenceBar(confidence: pred.confidence),
        ],
      ),
    );
  }

  Widget _buildInsufficientData() {
    final cyclesNeeded = (3 - completedCycleCount).clamp(0, 3);
    final String message;
    if (cyclesNeeded > 0) {
      final s = cyclesNeeded == 1 ? '' : 's';
      message = 'Log $cyclesNeeded more complete cycle${s} to unlock predictions.';
    } else {
      message = 'Calculating your first prediction...';
    }

    return Semantics(
      label: 'Log more cycles for predictions. $completedCycleCount of 3 cycles logged.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Predictions', style: AppTypography.heading3),
          const SizedBox(height: AppSizes.space12),
          Row(
            children: [
              Icon(Icons.hourglass_top_rounded, size: AppSizes.iconMedium, color: AppColors.primary.withAlpha(153)),
              const SizedBox(width: AppSizes.space12),
              Expanded(child: Text(message, style: AppTypography.body2.copyWith(color: AppColors.textSecondary))),
            ],
          ),
          const SizedBox(height: AppSizes.space16),
          _CycleProgressDots(completedCount: completedCycleCount.clamp(0, 3)),
        ],
      ),
    );
  }
}

class _FertileWindowRow extends StatelessWidget {
  const _FertileWindowRow({required this.start, required this.end});
  final DateTime start; final DateTime end;
  static final _dateFormat = DateFormat('MMM d');

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Fertile window: ${_dateFormat.format(start)} to ${_dateFormat.format(end)}',
      child: Container(
        padding: const EdgeInsets.all(AppSizes.space12),
        decoration: BoxDecoration(
          color: AppColors.ovulatory.withAlpha(20),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          border: Border.all(color: AppColors.ovulatory.withAlpha(51)),
        ),
        child: Row(
          children: [
            Icon(Icons.spa_rounded, size: AppSizes.iconSmall, color: AppColors.ovulatory),
            const SizedBox(width: AppSizes.space8),
            Text('Fertile window', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
            const Spacer(),
            Text('${_dateFormat.format(start)} – ${_dateFormat.format(end)}', style: AppTypography.body2.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _ConfidenceBar extends StatelessWidget {
  const _ConfidenceBar({required this.confidence});
  final double confidence;

  @override
  Widget build(BuildContext context) {
    final percent = (confidence * 100).round();
    final Color color;
    if (confidence >= 0.7) { color = AppColors.success; }
    else if (confidence >= 0.4) { color = AppColors.ovulatory; }
    else { color = AppColors.menstrual; }
    return Semantics(
      label: 'Prediction confidence $percent percent',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Confidence', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
            Text('$percent%', style: AppTypography.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: AppSizes.space4),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            child: LinearProgressIndicator(value: confidence.clamp(0.0, 1.0), minHeight: 6, backgroundColor: AppColors.divider, valueColor: AlwaysStoppedAnimation<Color>(color)),
          ),
        ],
      ),
    );
  }
}

class _CycleProgressDots extends StatelessWidget {
  const _CycleProgressDots({required this.completedCount});
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$completedCount of 3 cycles completed',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final filled = index < completedCount;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.space4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: AppSizes.animStandard),
              width: 32, height: 8,
              decoration: BoxDecoration(
                color: filled ? AppColors.primary : AppColors.divider,
                borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              ),
            ),
          );
        }),
      ),
    );
  }
}
