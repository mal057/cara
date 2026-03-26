import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// The visual emphasis level of a [SolaButton].
enum SolaButtonVariant {
  /// Filled background with primary colour — main call to action.
  primary,

  /// Outlined border with primary colour — secondary action.
  secondary,

  /// Filled background with error colour — destructive action.
  danger,
}

/// A branded, accessible button that supports [primary], [secondary], and
/// [danger] variants.
///
/// All touch targets meet the minimum 44 dp requirement defined by
/// [AppSizes.touchTarget]. Tapping triggers a light haptic pulse via
/// [HapticFeedback.lightImpact].
///
/// When [isLoading] is true the label is replaced with a small
/// [CircularProgressIndicator] and the button is disabled.
///
/// Examples:
/// ```dart
/// // Primary
/// SolaButton(label: 'Save', onPressed: _save);
///
/// // Secondary
/// SolaButton(
///   label: 'Cancel',
///   variant: SolaButtonVariant.secondary,
///   onPressed: _cancel,
/// );
///
/// // Danger
/// SolaButton(
///   label: 'Delete all data',
///   variant: SolaButtonVariant.danger,
///   onPressed: _confirmDelete,
/// );
///
/// // Full-width
/// SolaButton(
///   label: 'Continue',
///   isFullWidth: true,
///   onPressed: _next,
/// );
/// ```
class SolaButton extends StatelessWidget {
  const SolaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SolaButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.enabled = true,
  });

  /// Button label text.
  final String label;

  /// Callback invoked on tap. Pass null to disable the button without
  /// using [enabled].
  final VoidCallback? onPressed;

  /// Visual emphasis level.
  final SolaButtonVariant variant;

  /// Optional leading icon displayed to the left of the label.
  final IconData? icon;

  /// When true, replaces the label with a loading indicator and disables
  /// interaction.
  final bool isLoading;

  /// When true, the button expands to fill the available horizontal space.
  final bool isFullWidth;

  /// Whether the button is interactive. Visually dimmed when false.
  final bool enabled;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  bool get _isDisabled => !enabled || isLoading || onPressed == null;

  VoidCallback? get _effectiveOnPressed {
    if (_isDisabled) return null;
    return () {
      HapticFeedback.lightImpact();
      onPressed!();
    };
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = _buildChild(context);

    switch (variant) {
      case SolaButtonVariant.primary:
        return _wrapFullWidth(_buildPrimary(child));
      case SolaButtonVariant.secondary:
        return _wrapFullWidth(_buildSecondary(child));
      case SolaButtonVariant.danger:
        return _wrapFullWidth(_buildDanger(child));
    }
  }

  // ---------------------------------------------------------------------------
  // Variant builders
  // ---------------------------------------------------------------------------

  Widget _buildPrimary(Widget child) {
    return ElevatedButton(
      onPressed: _effectiveOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        disabledBackgroundColor: AppColors.primary.withAlpha(102),
        disabledForegroundColor: AppColors.surface.withAlpha(153),
        minimumSize: const Size(AppSizes.touchTarget, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        ),
      ),
      child: child,
    );
  }

  Widget _buildSecondary(Widget child) {
    return OutlinedButton(
      onPressed: _effectiveOnPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.primary.withAlpha(102),
        minimumSize: const Size(AppSizes.touchTarget, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        side: BorderSide(
          color: _isDisabled
              ? AppColors.primary.withAlpha(102)
              : AppColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        ),
      ),
      child: child,
    );
  }

  Widget _buildDanger(Widget child) {
    return ElevatedButton(
      onPressed: _effectiveOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.surface,
        disabledBackgroundColor: AppColors.error.withAlpha(102),
        disabledForegroundColor: AppColors.surface.withAlpha(153),
        minimumSize: const Size(AppSizes.touchTarget, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        ),
      ),
      child: child,
    );
  }

  // ---------------------------------------------------------------------------
  // Shared child content
  // ---------------------------------------------------------------------------

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      final Color indicatorColor = variant == SolaButtonVariant.secondary
          ? AppColors.primary
          : AppColors.surface;
      return SizedBox(
        width: AppSizes.iconMedium,
        height: AppSizes.iconMedium,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        ),
      );
    }

    if (icon != null) {
      final Color iconColor = variant == SolaButtonVariant.secondary
          ? AppColors.primary
          : AppColors.surface;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSmall, color: iconColor),
          const SizedBox(width: AppSizes.space8),
          Text(label, style: AppTypography.button),
        ],
      );
    }

    return Text(label, style: AppTypography.button);
  }

  Widget _wrapFullWidth(Widget button) {
    if (!isFullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
