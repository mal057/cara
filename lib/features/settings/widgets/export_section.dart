import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/export_format.dart';
import '../../../core/enums/export_range.dart';
import '../../../data/models/export_data_model.dart';
import '../../../providers/cycle_providers.dart';
import '../../../providers/export_providers.dart';
import '../../../services/export/export_service.dart';
import '../../shared/widgets/cara_button.dart';

/// Inline export widget embedded in the Data section of SettingsScreen.
///
/// Shows a format toggle (CSV / PDF) and a date-range chip selector.
/// Tapping Export assembles [ExportDataModel] from providers and calls
/// [ExportService.exportCsv] or [ExportService.exportPdf], then shares
/// via the OS share sheet.
class ExportSection extends ConsumerStatefulWidget {
  const ExportSection({super.key});

  @override
  ConsumerState<ExportSection> createState() => _ExportSectionState();
}

class _ExportSectionState extends ConsumerState<ExportSection> {
  ExportFormat _format = ExportFormat.csv;
  ExportRange _range = ExportRange.threeMonths;

  Future<void> _onExport() async {
    final status = ref.read(exportStatusProvider);
    if (status == ExportStatus.generating) return;

    ref.read(exportStatusProvider.notifier).state = ExportStatus.generating;

    try {
      final exportService = ref.read(exportServiceProvider);
      final cycles = await ref.read(completedCyclesProvider.future);
      final now = DateTime.now();
      final startDate = _range.startDate(now);

      final data = ExportDataModel(
        range: _range,
        startDate: startDate,
        endDate: now,
        cycles: cycles
            .map((c) => c as dynamic)
            .toList()
            .cast(),
        dailyData: const [],
        stats: null,
      );

      final File file;
      if (_format == ExportFormat.csv) {
        file = await exportService.exportCsv(_range, data);
      } else {
        file = await exportService.exportPdf(_range, data);
      }

      await exportService.shareFile(file);

      if (!mounted) return;
      ref.read(exportStatusProvider.notifier).state = ExportStatus.complete;
    } catch (e) {
      if (!mounted) return;
      ref.read(exportStatusProvider.notifier).state = ExportStatus.error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(exportStatusProvider);
    final isGenerating = status == ExportStatus.generating;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding, vertical: AppSizes.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Format selector
          Text('Format',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSizes.space8),
          Row(
            children: ExportFormat.values.map((f) {
              final selected = _format == f;
              return Padding(
                padding:
                    const EdgeInsets.only(right: AppSizes.space8),
                child: ChoiceChip(
                  label: Text(f.displayName),
                  selected: selected,
                  onSelected: (_) => setState(() => _format = f),
                  selectedColor: AppColors.primary.withAlpha(26),
                  labelStyle: AppTypography.chip.copyWith(
                    color: selected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.divider,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSizes.space16),
          // Range selector
          Text('Date Range',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSizes.space8),
          Wrap(
            spacing: AppSizes.space8,
            runSpacing: AppSizes.space8,
            children: ExportRange.values.map((r) {
              final selected = _range == r;
              return ChoiceChip(
                label: Text(r.displayName),
                selected: selected,
                onSelected: (_) => setState(() => _range = r),
                selectedColor: AppColors.primary.withAlpha(26),
                labelStyle: AppTypography.chip.copyWith(
                  color: selected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                ),
                side: BorderSide(
                  color: selected ? AppColors.primary : AppColors.divider,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSizes.space20),
          CaraButton(
            label: isGenerating ? 'Generating...' : 'Export ${_format.displayName}',
            isFullWidth: true,
            isLoading: isGenerating,
            icon: Icons.upload_outlined,
            onPressed: isGenerating ? null : _onExport,
          ),
          if (status == ExportStatus.complete) ...[
            const SizedBox(height: AppSizes.space8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline_rounded,
                    color: AppColors.success, size: AppSizes.iconSmall),
                const SizedBox(width: AppSizes.space4),
                Text('Export shared successfully',
                    style: AppTypography.caption
                        .copyWith(color: AppColors.success)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
