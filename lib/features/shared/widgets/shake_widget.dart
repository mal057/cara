import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable widget that wraps [child] in a horizontal shake animation.
///
/// Call [ShakeWidgetState.shake] via a [GlobalKey] to trigger a 300 ms
/// left-right oscillation and a [HapticFeedback.mediumImpact] pulse.
///
/// Example:
/// ```dart
/// final _shakeKey = GlobalKey<ShakeWidgetState>();
///
/// // Trigger on wrong PIN:
/// _shakeKey.currentState?.shake();
///
/// // Wrap content:
/// ShakeWidget(key: _shakeKey, child: PinDots(...));
/// ```
class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    super.key,
    required this.child,
  });

  /// The widget to animate.
  final Widget child;

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Left-right oscillation: 0 → -8 → 8 → -6 → 6 → 0 px
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Triggers the shake animation with a medium haptic pulse.
  Future<void> shake() async {
    HapticFeedback.mediumImpact();
    await _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.translate(
        offset: Offset(_animation.value, 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}
