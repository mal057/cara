import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A complete PIN entry widget composed of:
///   - A row of filled / empty indicator dots (one per expected digit).
///   - An optional error message shown below the dots.
///   - A shake animation controller that the parent drives via [shakeKey].
///
/// [PinInput] is a pure display + haptic widget — it does NOT render the
/// numeric key-pad; the pad is owned by [LockScreen] so the two can be
/// positioned independently.  The parent passes [pinLength] (how many digits
/// have been entered so far) and [maxLength] (4–6), and [PinInput] renders
/// the correct number of filled circles.
///
/// Shake animation:
/// ```dart
/// final _shakeKey = GlobalKey<PinInputState>();
/// // ... on wrong PIN:
/// _shakeKey.currentState?.shake();
/// ```
class PinInput extends StatefulWidget {
  const PinInput({
    super.key,
    required this.pinLength,
    this.maxLength = 4,
    this.errorMessage,
    this.dotColor,
    this.emptyDotColor,
  }) : assert(
          maxLength >= 4 && maxLength <= 6,
          'maxLength must be between 4 and 6',
        );

  /// Number of digits entered so far (0 … [maxLength]).
  final int pinLength;

  /// Total number of PIN digits expected (4, 5, or 6).
  final int maxLength;

  /// When non-null, shown in red below the dot row.
  final String? errorMessage;

  /// Colour of a filled dot. Defaults to [AppColors.primary].
  final Color? dotColor;

  /// Colour of an empty dot outline. Defaults to [AppColors.inputBorder].
  final Color? emptyDotColor;

  @override
  State<PinInput> createState() => PinInputState();
}

class PinInputState extends State<PinInput>
    with TickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  // Per-dot bounce controllers — one per maximum possible dot (up to 6).
  final List<AnimationController> _dotControllers = [];
  final List<Animation<double>> _dotScaleAnimations = [];

  // Track previous pinLength to know which dot just filled.
  int _prevPinLength = 0;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // Horizontal shake: left–right oscillation via a sine-like sequence.
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: -4.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));

    // Build one bounce controller per possible dot slot.
    for (int i = 0; i < 6; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );
      final animation = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.3, end: 1.0),
          weight: 1,
        ),
      ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

      _dotControllers.add(controller);
      _dotScaleAnimations.add(animation);
    }

    _prevPinLength = widget.pinLength;
  }

  @override
  void didUpdateWidget(PinInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A new digit was added — bounce the newly filled dot.
    if (widget.pinLength > _prevPinLength && widget.pinLength > 0) {
      final filledIndex = widget.pinLength - 1;
      if (filledIndex < _dotControllers.length) {
        _dotControllers[filledIndex].forward(from: 0.0);
      }
    }

    _prevPinLength = widget.pinLength;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    for (final c in _dotControllers) {
      c.dispose();
    }
    super.dispose();
  }

  /// Triggers the horizontal shake animation.
  ///
  /// Call this after a wrong-PIN attempt is detected.
  /// Also fires a [HapticFeedback.mediumImpact] pulse.
  Future<void> shake() async {
    HapticFeedback.mediumImpact();
    await _shakeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final filled = widget.dotColor ?? AppColors.primary;
    final empty = widget.emptyDotColor ?? AppColors.divider;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dot row inside the shake translation.
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.maxLength, (index) {
              final isFilled = index < widget.pinLength;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: ScaleTransition(
                  scale: index < _dotScaleAnimations.length
                      ? _dotScaleAnimations[index]
                      : const AlwaysStoppedAnimation(1.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: AppSizes.animFast),
                    curve: Curves.easeOut,
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? filled : Colors.transparent,
                      border: Border.all(
                        color: isFilled ? filled : empty,
                        width: 2.0,
                      ),
                      boxShadow: isFilled
                          ? [
                              BoxShadow(
                                color: filled.withAlpha(70),
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        // Error message — fades in softly.
        AnimatedSize(
          duration: Duration(milliseconds: AppSizes.animStandard),
          curve: Curves.easeOut,
          child: widget.errorMessage != null
              ? Padding(
                  padding: const EdgeInsets.only(top: AppSizes.space16),
                  child: AnimatedOpacity(
                    opacity: widget.errorMessage != null ? 1.0 : 0.0,
                    duration: Duration(milliseconds: AppSizes.animStandard),
                    curve: Curves.easeIn,
                    child: Text(
                      widget.errorMessage!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.error,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      semanticsLabel: widget.errorMessage,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
