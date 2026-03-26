import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A custom numeric PIN pad widget used in [PinSetupScreen] and [LockScreen].
///
/// Renders a 3x4 grid of keys (digits 1–9, blank, 0, backspace).
/// Each tap triggers [HapticFeedback.lightImpact] and invokes [onDigit] or
/// [onBackspace] as appropriate.
///
/// The caller is responsible for tracking the entered digits; this widget is
/// purely presentational and stateless.
class PinPad extends StatelessWidget {
  const PinPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  /// Called with the digit string ('0'–'9') when a digit key is tapped.
  final void Function(String digit) onDigit;

  /// Called when the backspace key is tapped.
  final VoidCallback onBackspace;

  static const List<String?> _keys = [
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9',
    null, '0', 'back',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: AppSizes.space8,
        crossAxisSpacing: AppSizes.space8,
      ),
      itemCount: _keys.length,
      itemBuilder: (context, index) {
        final key = _keys[index];
        if (key == null) {
          // Empty spacer cell (bottom-left position).
          return const SizedBox.shrink();
        }
        if (key == 'back') {
          return _PinKey(
            child: Icon(
              Icons.backspace_outlined,
              size: AppSizes.iconMedium,
              color: AppColors.textPrimary,
              semanticLabel: 'Delete last digit',
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              onBackspace();
            },
          );
        }
        return _PinKey(
          child: Text(
            key,
            style: AppTypography.pinDigit,
          ),
          onTap: () {
            HapticFeedback.lightImpact();
            onDigit(key);
          },
        );
      },
    );
  }
}

/// A single circular tap target for the PIN pad.
class _PinKey extends StatelessWidget {
  const _PinKey({
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.pinKeySize,
        height: AppSizes.pinKeySize,
        child: Semantics(
          button: true,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              splashColor: AppColors.primary.withAlpha(40),
              highlightColor: AppColors.primary.withAlpha(20),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.divider,
                    width: 1.5,
                  ),
                ),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
