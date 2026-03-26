import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A multiline text input for daily notes with a live character counter.
///
/// Maximum length is 500 characters, enforced both via [maxLength] and the
/// [InputDecoration] counter label. The field expands vertically as the user
/// types rather than scrolling internally.
///
/// The controller is managed externally so the parent screen can read the
/// current value and pre-populate it with saved data.
class NotesInput extends StatelessWidget {
  const NotesInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
  });

  /// External [TextEditingController] that holds the note text.
  final TextEditingController controller;

  /// Optional [FocusNode] for managing keyboard focus.
  final FocusNode? focusNode;

  /// Called on every keystroke with the current text value.
  final ValueChanged<String>? onChanged;

  static const int _maxLength = 500;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          maxLength: _maxLength,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          style: AppTypography.body1,
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) {
            final remaining = (maxLength ?? _maxLength) - currentLength;
            final isNearLimit = remaining <= 50;
            return Text(
              '$currentLength / ${maxLength ?? _maxLength}',
              style: AppTypography.caption.copyWith(
                color: isNearLimit ? AppColors.error : AppColors.textSecondary,
              ),
            );
          },
          decoration: InputDecoration(
            hintText: 'How are you feeling today?',
            hintStyle: AppTypography.body1.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.all(AppSizes.space16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
