import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// The visual emphasis level of a [CaraButton].
enum CaraButtonVariant {
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
/// CaraButton(label: 'Save', onPressed: _save);
///
/// // Secondary
/// CaraButton(
///   label: 'Cancel',
///   variant: CaraButtonVariant.secondary,
///   onPressed: _cancel,
/// );
///
/// // Danger
/// CaraButton(
///   label: 'Delete all data',
///   variant: CaraButtonVariant.danger,
///   onPressed: _confirmDelete,
/// );
///
/// // Full-width
/// CaraButton(
///   label: 'Continue',
///   isFullWidth: true,
///   onPressed: _next,
/// );
/// ```
class CaraButton extends StatelessWidget {
  const CaraButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = CaraButtonVariant.primary,
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
  final CaraButtonVariant variant;

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
      case CaraButtonVariant.primary:
        return _wrapFullWidth(_buildPrimary(child));
      case CaraButtonVariant.secondary:
        return _wrapFullWidth(_buildSecondary(child));
      case CaraButtonVariant.danger:
        return _wrapFullWidth(_buildDanger(child));
    }
  }

  // ---------------------------------------------------------------------------
  // Variant builders
  // ---------------------------------------------------------------------------

  Widget _buildPrimary(Widget child) {
    final bool disabled = _isDisabled;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: disabled
            ? null
            : const LinearGradient(
                colors: [AppColors.primary, Color(0xFF8B5FBF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        color: disabled ? AppColors.primary.withAlpha(102) : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: disabled
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withAlpha(80),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: _effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: AppColors.surface,
          disabledForegroundColor: AppColors.surface.withAlpha(153),
          disabledBackgroundColor: Colors.transparent,
          minimumSize: const Size(AppSizes.touchTarget, AppSizes.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: child,
      ),
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
        backgroundColor: AppColors.primary.withAlpha(18),
        side: BorderSide(
          color: _isDisabled
              ? AppColors.primary.withAlpha(60)
              : AppColors.primary.withAlpha(140),
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: child,
    );
  }

  Widget _buildDanger(Widget child) {
    final bool disabled = _isDisabled;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: disabled
            ? null
            : const LinearGradient(
                colors: [AppColors.error, Color(0xFFE06B5E)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        color: disabled ? AppColors.error.withAlpha(102) : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: disabled
            ? null
            : [
                BoxShadow(
                  color: AppColors.error.withAlpha(70),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: _effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: AppColors.surface,
          disabledForegroundColor: AppColors.surface.withAlpha(153),
          disabledBackgroundColor: Colors.transparent,
          minimumSize: const Size(AppSizes.touchTarget, AppSizes.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: child,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared child content
  // ---------------------------------------------------------------------------

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      final Color indicatorColor = variant == CaraButtonVariant.secondary
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
      final Color iconColor = variant == CaraButtonVariant.secondary
          ? AppColors.primary
          : AppColors.surface;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSmall, color: iconColor),
          const SizedBox(width: AppSizes.space8),
          Text(label, style: AppTypography.button.copyWith(letterSpacing: 1.2)),
        ],
      );
    }

    return Text(label, style: AppTypography.button.copyWith(letterSpacing: 1.2));
  }

  Widget _wrapFullWidth(Widget button) {
    if (!isFullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
