import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/symptom_definitions.dart';
import '../../../core/enums/symptom_severity.dart';
import '../../shared/widgets/symptom_icon.dart';

/// Map from symptom definition ID to the currently selected severity.
///
/// A null value means the symptom is not selected. The entry is only present
/// in the map if the symptom has been toggled on at least once.
typedef SymptomSelections = Map<String, SymptomSeverity?>;

/// A responsive wrap-grid of symptom chips.
///
/// Each chip represents one of the 16 [kSymptomDefinitions]. The chip can be:
/// - Unselected: neutral appearance, tap to select at [SymptomSeverity.mild].
/// - Selected: highlighted with a severity indicator and severity label.
///   Tapping a selected chip cycles severity mild → moderate → severe → deselect.
/// - Long-press on a selected chip shows the severity as a tooltip.
///
/// [onChanged] is called after every tap with the full updated [SymptomSelections]
/// map so the parent can keep the state.
class SymptomGrid extends StatelessWidget {
  const SymptomGrid({
    super.key,
    required this.selections,
    required this.onChanged,
  });

  /// Current symptom selection state keyed by symptom definition ID.
  final SymptomSelections selections;

  /// Called when the user taps any chip, with the updated selection state.
  final ValueChanged<SymptomSelections> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.space8,
      runSpacing: AppSizes.space8,
      children: kSymptomDefinitions.map((def) {
        final currentSeverity = selections[def.id];
        final isSelected = currentSeverity != null;

        return _SymptomChip(
          definition: def,
          severity: currentSeverity,
          isSelected: isSelected,
          onTap: () => _handleTap(def.id),
        );
      }).toList(),
    );
  }

  void _handleTap(String symptomId) {
    HapticFeedback.selectionClick();
    final updated = Map<String, SymptomSeverity?>.from(selections);
    final current = updated[symptomId];

    if (current == null) {
      // Not selected → select at mild
      updated[symptomId] = SymptomSeverity.mild;
    } else if (current == SymptomSeverity.mild) {
      updated[symptomId] = SymptomSeverity.moderate;
    } else if (current == SymptomSeverity.moderate) {
      updated[symptomId] = SymptomSeverity.severe;
    } else {
      // severe → deselect
      updated[symptomId] = null;
    }

    onChanged(updated);
  }
}

class _SymptomChip extends StatelessWidget {
  const _SymptomChip({
    required this.definition,
    required this.severity,
    required this.isSelected,
    required this.onTap,
  });

  final SymptomDefinition definition;
  final SymptomSeverity? severity;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _activeColor {
    switch (definition.category.displayName) {
      case 'Mood':
        return AppColors.luteal;
      case 'Pain':
        return AppColors.menstrual;
      case 'Energy':
        return AppColors.ovulatory;
      case 'Skin':
        return AppColors.follicular;
      case 'Digestion':
        return AppColors.secondary;
      case 'Sleep':
        return AppColors.lutealPredicted;
      default:
        return AppColors.primary;
    }
  }

  String get _severityLabel {
    if (severity == null) return '';
    switch (severity!) {
      case SymptomSeverity.mild:
        return '•';
      case SymptomSeverity.moderate:
        return '••';
      case SymptomSeverity.severe:
        return '•••';
    }
  }

  String get _semanticLabel {
    final severityText = severity != null ? ', ${severity!.displayName}' : '';
    return '${definition.name}$severityText. '
        '${isSelected ? "Tap to increase severity or deselect." : "Tap to select."}';
  }

  @override
  Widget build(BuildContext context) {
    final Color chipColor = isSelected ? _activeColor : AppColors.inputBorder;
    final Color bgColor =
        isSelected ? _activeColor.withAlpha(30) : Colors.transparent;
    final Color contentColor =
        isSelected ? _activeColor : AppColors.textSecondary;

    return Semantics(
      label: _semanticLabel,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: AppSizes.animFast),
          curve: Curves.easeInOut,
          constraints: const BoxConstraints(minHeight: AppSizes.touchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.space12,
            vertical: AppSizes.space8,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            border: Border.all(color: chipColor, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SymptomIcon(icon: definition.icon, emoji: definition.emoji, size: AppSizes.iconSmall, color: contentColor),
              const SizedBox(width: AppSizes.tinyGap),
              Text(
                definition.name,
                style: AppTypography.chip.copyWith(color: contentColor),
              ),
              if (isSelected && _severityLabel.isNotEmpty) ...[
                const SizedBox(width: AppSizes.tinyGap),
                Text(
                  _severityLabel,
                  style: AppTypography.caption.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
