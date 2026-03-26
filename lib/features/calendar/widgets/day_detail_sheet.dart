import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/symptom_definitions.dart';
import '../../../core/enums/cycle_phase.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../data/models/day_data_model.dart';
import '../../../services/cycle/phase_calculator.dart';
import '../../../data/models/symptom_entry_model.dart';

/// Modal bottom sheet showing the selected day's cycle data.
///
/// Shows:
/// - Date header with phase badge
/// - Period status (logged or none)
/// - Symptom chips for logged symptoms
/// - Daily note preview (if any)
/// - Quick-log button to navigate to LogScreen
///
/// Opened by [CalendarScreen] when the user taps a day.
/// Does not write data - read-only summary, full edits happen in LogScreen.
class DayDetailSheet extends StatelessWidget {
  const DayDetailSheet({
    super.key,
    required this.date,
    required this.dayData,
  });

  final DateTime date;
  final DayDataModel? dayData;

  static Future<void> show(
    BuildContext context,
    DateTime date,
    DayDataModel? dayData,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DayDetailSheet(date: date, dayData: dayData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phase = dayData?.phase;
    final hasPeriod = dayData?.periodLog != null;
    final symptoms = dayData?.symptomEntries ?? const [];
    final note = dayData?.dailyNote?.content;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      snap: true,
      snapSizes: const [0.5, 0.85],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusLarge),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.space12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                  ),
                ),
              ),
              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSizes.space24),
                  children: [
                    _DateHeader(date: date, phase: phase),
                    const SizedBox(height: AppSizes.space16),
                    _PeriodStatusRow(hasPeriod: hasPeriod, dayData: dayData),
                    if (symptoms.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.space16),
                      _SymptomSummary(symptomEntries: symptoms),
                    ],
                    if (note != null && note.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.space16),
                      _NotePreview(content: note),
                    ],
                    const SizedBox(height: AppSizes.space24),
                    _LogButton(date: date),
                    const SizedBox(height: AppSizes.space16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// _DateHeader
// ---------------------------------------------------------------------------

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date, required this.phase});

  final DateTime date;
  final CyclePhase? phase;

  @override
  Widget build(BuildContext context) {
    final phaseColor = phase != null
        ? PhaseCalculator.getPhaseColor(phase!)
        : AppColors.primary;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.formatted,
                style: AppTypography.heading3,
              ),
              if (phase != null)
                Text(
                  phase!.description,
                  style: AppTypography.body2.copyWith(
                    color: phaseColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        // Phase colour dot
        if (phase != null)
          Container(
            width: AppSizes.space16,
            height: AppSizes.space16,
            decoration: BoxDecoration(
              color: phaseColor,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _PeriodStatusRow
// ---------------------------------------------------------------------------

class _PeriodStatusRow extends StatelessWidget {
  const _PeriodStatusRow({required this.hasPeriod, required this.dayData});

  final bool hasPeriod;
  final DayDataModel? dayData;

  @override
  Widget build(BuildContext context) {
    final log = dayData?.periodLog;

    return Container(
      padding: const EdgeInsets.all(AppSizes.space12),
      decoration: BoxDecoration(
        color: hasPeriod
            ? AppColors.menstrual.withAlpha(20)
            : AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(
          color: hasPeriod
              ? AppColors.menstrual.withAlpha(77)
              : AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasPeriod
                ? Icons.water_drop
                : Icons.water_drop_outlined,
            color: hasPeriod ? AppColors.menstrual : AppColors.textSecondary,
            size: AppSizes.iconMedium,
          ),
          const SizedBox(width: AppSizes.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasPeriod ? 'Period' : 'No period logged',
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: hasPeriod
                        ? AppColors.menstrual
                        : AppColors.textSecondary,
                  ),
                ),
                if (log != null)
                  Text(
                    log.flowIntensity.displayName,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _SymptomSummary
// ---------------------------------------------------------------------------

class _SymptomSummary extends StatelessWidget {
  const _SymptomSummary({required this.symptomEntries});

  final List<SymptomEntryModel> symptomEntries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Symptoms',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.space8),
        Wrap(
          spacing: AppSizes.space8,
          runSpacing: AppSizes.space8,
          children: symptomEntries.map((entry) {
            // Find matching symptom definition for icon
            final def = kSymptomDefinitions.where(
              (s) => s.id == entry.symptomId.toString() ||
                  (entry.symptom != null &&
                      s.id == entry.symptom!.name.toLowerCase()),
            ).firstOrNull;

            return _SymptomChip(
              label: entry.symptom?.name ?? entry.symptomId.toString(),
              icon: def?.icon ?? Icons.circle_outlined,
              severity: entry.severity.displayName,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SymptomChip extends StatelessWidget {
  const _SymptomChip({
    required this.label,
    required this.icon,
    required this.severity,
  });

  final String label;
  final IconData icon;
  final String severity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space8,
        vertical: AppSizes.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(13),
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        border: Border.all(
          color: AppColors.primary.withAlpha(51),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSmall, color: AppColors.primary),
          const SizedBox(width: AppSizes.space4),
          Text(
            label,
            style: AppTypography.chip.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _NotePreview
// ---------------------------------------------------------------------------

class _NotePreview extends StatelessWidget {
  const _NotePreview({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.space8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.space12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            border: Border.all(color: AppColors.divider),
          ),
          child: Text(
            content,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _LogButton
// ---------------------------------------------------------------------------

class _LogButton extends StatelessWidget {
  const _LogButton({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          // Navigation to LogScreen with date pre-filled
          // handled by the router when log tab is selected.
          // Consumers can listen to selectedDateProvider.
        },
        icon: const Icon(Icons.edit_outlined, size: AppSizes.iconSmall),
        label: Text('Log this day'),
      ),
    );
  }
}
