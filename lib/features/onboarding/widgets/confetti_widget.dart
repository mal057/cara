import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// A pure-Flutter confetti particle overlay.
///
/// Renders a burst of coloured rectangular particles that fall from the top
/// of the widget. Plays once automatically when [play] is called via a
/// [GlobalKey<ConfettiWidgetState>].
///
/// Uses a single [AnimationController] driving per-particle physics — no
/// third-party package required.
///
/// Example:
/// ```dart
/// final _confettiKey = GlobalKey<ConfettiWidgetState>();
///
/// // Trigger on onboarding complete:
/// _confettiKey.currentState?.play();
///
/// // Overlay above content:
/// Stack(
///   children: [
///     content,
///     ConfettiWidget(key: _confettiKey),
///   ],
/// )
/// ```
class ConfettiWidget extends StatefulWidget {
  const ConfettiWidget({super.key});

  @override
  State<ConfettiWidget> createState() => ConfettiWidgetState();
}

class ConfettiWidgetState extends State<ConfettiWidget>
    with SingleTickerProviderStateMixin {
  static const int _particleCount = 60;
  static const List<Color> _palette = [
    AppColors.primary,
    AppColors.menstrual,
    AppColors.follicular,
    AppColors.ovulatory,
    AppColors.luteal,
    AppColors.secondary,
  ];

  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final math.Random _rng = math.Random();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _particles = List.generate(_particleCount, (_) => _Particle(_rng));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _visible = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Starts the confetti burst. Safe to call multiple times; restarts from 0.
  void play() {
    if (!mounted) return;
    for (final p in _particles) {
      p.reset(_rng);
    }
    setState(() => _visible = true);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: _ConfettiPainter(
              particles: _particles,
              progress: _controller.value,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _Particle
// ---------------------------------------------------------------------------

class _Particle {
  late double startX;
  late double velocityX;
  late double velocityY;
  late double rotationSpeed;
  late double size;
  late Color color;
  late double delay;

  _Particle(math.Random rng) {
    reset(rng);
  }

  void reset(math.Random rng) {
    startX = rng.nextDouble(); // 0-1 relative to canvas width
    velocityX = (rng.nextDouble() - 0.5) * 0.4; // horizontal drift
    velocityY = 0.5 + rng.nextDouble() * 0.6; // fall speed (relative)
    rotationSpeed = (rng.nextDouble() - 0.5) * 8.0;
    size = 4.0 + rng.nextDouble() * 6.0;
    color = ConfettiWidgetState._palette[
        rng.nextInt(ConfettiWidgetState._palette.length)];
    delay = rng.nextDouble() * 0.3; // stagger launch time
  }
}

// ---------------------------------------------------------------------------
// _ConfettiPainter
// ---------------------------------------------------------------------------

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  final List<_Particle> particles;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      // Each particle has an individual delay before it starts moving.
      final t = ((progress - p.delay) / (1.0 - p.delay)).clamp(0.0, 1.0);
      if (t <= 0.0) continue;

      // Fade out in the last 20% of lifetime.
      final opacity = t > 0.8 ? (1.0 - t) / 0.2 : 1.0;
      paint.color = p.color.withAlpha((opacity * 220).round());

      final x = (p.startX + p.velocityX * t) * size.width;
      final y = -p.size + p.velocityY * t * size.height;
      final rotation = t * p.rotationSpeed;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.55,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) =>
      old.progress != progress;
}
