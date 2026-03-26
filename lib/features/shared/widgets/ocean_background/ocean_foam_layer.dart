import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'ocean_config.dart';

/// Foam and sparkle particle overlay for the ocean background.
///
/// Renders continuously-recycling particles that simulate sea foam
/// dissipating and sunlight catching wave peaks.
///
/// Receives an external [animation] (typically the parent's
/// [AnimationController]) to drive repaints — it does NOT own its own
/// controller. Colors are supplied from outside so they track the
/// time-of-day palette without this widget needing to know about
/// [OceanTimeColors] directly.
///
/// Example:
/// ```dart
/// OceanFoamLayer(
///   animation: _controller,
///   foamColor: palette.foam,
///   sparkleColor: palette.sparkle,
/// )
/// ```
class OceanFoamLayer extends StatefulWidget {
  const OceanFoamLayer({
    super.key,
    required this.animation,
    required this.foamColor,
    required this.sparkleColor,
  });

  /// Parent's animation to trigger repaints (usually AnimationController.repeat).
  final Animation<double> animation;

  /// Current foam color from the time-of-day palette.
  final Color foamColor;

  /// Current sparkle color from the time-of-day palette.
  final Color sparkleColor;

  @override
  State<OceanFoamLayer> createState() => _OceanFoamLayerState();
}

class _OceanFoamLayerState extends State<OceanFoamLayer> {
  final math.Random _rng = math.Random();
  late final List<_FoamParticle> _foamParticles;
  late final List<_SparkleParticle> _sparkleParticles;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _foamParticles = List.generate(
      OceanConfig.foamParticleCount,
      (_) => _FoamParticle(_rng),
    );
    _sparkleParticles = List.generate(
      OceanConfig.sparkleCount,
      (_) => _SparkleParticle(_rng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: widget.animation,
        builder: (_, __) {
          final elapsed = _stopwatch.elapsedMilliseconds / 1000.0;
          return CustomPaint(
            painter: _FoamPainter(
              foamParticles: _foamParticles,
              sparkleParticles: _sparkleParticles,
              elapsed: elapsed,
              foamColor: widget.foamColor,
              sparkleColor: widget.sparkleColor,
              rng: _rng,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _FoamParticle
// ---------------------------------------------------------------------------

class _FoamParticle {
  double x;
  double y;
  double size;
  double lifetime;
  double born;
  double driftX;
  double driftY;

  _FoamParticle(math.Random rng)
      : x = 0,
        y = 0,
        size = 0,
        lifetime = 0,
        born = 0,
        driftX = 0,
        driftY = 0 {
    reset(rng, 0.0);
  }

  void reset(math.Random rng, double currentTime) {
    x = rng.nextDouble();
    // Spawn in the middle-to-bottom water zone (avoids the horizon edge).
    y = rng.nextDouble() * 0.6 + 0.1;
    size = OceanConfig.foamMinSize +
        rng.nextDouble() * (OceanConfig.foamMaxSize - OceanConfig.foamMinSize);
    lifetime = OceanConfig.foamMinLifetime +
        rng.nextDouble() *
            (OceanConfig.foamMaxLifetime - OceanConfig.foamMinLifetime);
    // Stagger initial birth times so particles don't all appear at once on
    // the first frame.
    born = currentTime - rng.nextDouble() * lifetime;
    driftX = (rng.nextDouble() - 0.5) * 0.02;
    // Negative = upward float (foam rises and disperses).
    driftY = -(0.005 + rng.nextDouble() * 0.01);
  }

  double age(double currentTime) => currentTime - born;

  bool isDead(double currentTime) => age(currentTime) >= lifetime;
}

// ---------------------------------------------------------------------------
// _SparkleParticle
// ---------------------------------------------------------------------------

class _SparkleParticle {
  double x;
  double y;
  double size;
  double born;
  double driftX;

  _SparkleParticle(math.Random rng)
      : x = 0,
        y = 0,
        size = 0,
        born = 0,
        driftX = 0 {
    reset(rng, 0.0);
  }

  void reset(math.Random rng, double currentTime) {
    // Concentrate sparkles near the horizontal centre where sunlight hits.
    x = 0.15 + rng.nextDouble() * 0.7;
    // Near the surface / horizon where glints appear.
    y = rng.nextDouble() * 0.4;
    size = OceanConfig.sparkleMinSize +
        rng.nextDouble() *
            (OceanConfig.sparkleMaxSize - OceanConfig.sparkleMinSize);
    // Stagger birth times across the full sparkle lifetime.
    born = currentTime - rng.nextDouble() * OceanConfig.sparkleLifetime;
    driftX = (rng.nextDouble() - 0.5) * 0.01;
  }

  double age(double currentTime) => currentTime - born;

  bool isDead(double currentTime) =>
      age(currentTime) >= OceanConfig.sparkleLifetime;
}

// ---------------------------------------------------------------------------
// _FoamPainter
// ---------------------------------------------------------------------------

class _FoamPainter extends CustomPainter {
  _FoamPainter({
    required this.foamParticles,
    required this.sparkleParticles,
    required this.elapsed,
    required this.foamColor,
    required this.sparkleColor,
    required this.rng,
  });

  final List<_FoamParticle> foamParticles;
  final List<_SparkleParticle> sparkleParticles;
  final double elapsed;
  final Color foamColor;
  final Color sparkleColor;
  final math.Random rng;

  @override
  void paint(Canvas canvas, Size size) {
    // Pixel Y of the horizon — particles only appear in the water zone below.
    final horizonPixelY = size.height * OceanConfig.horizonY;
    final waterHeight = size.height - horizonPixelY;

    final paint = Paint()..style = PaintingStyle.fill;

    // --- Foam particles ---
    for (final p in foamParticles) {
      if (p.isDead(elapsed)) {
        p.reset(rng, elapsed);
      }

      final age = p.age(elapsed);
      final t = (age / p.lifetime).clamp(0.0, 1.0);

      // Fade in during first 10 %, hold, then fade out over the last 30 %.
      final double opacity;
      if (t < 0.1) {
        opacity = t / 0.1;
      } else if (t > 0.7) {
        opacity = (1.0 - t) / 0.3;
      } else {
        opacity = 1.0;
      }

      // Wrap x-position so particles that drift off the right edge re-enter
      // from the left seamlessly.
      final px = ((p.x + p.driftX * age) % 1.0) * size.width;
      final py = horizonPixelY +
          (p.y + p.driftY * age).clamp(0.0, 1.0) * waterHeight;

      // Blend the caller-supplied alpha with the particle's fade opacity so
      // time-of-day colours that are already semi-transparent remain correct.
      final baseAlpha = foamColor.alpha / 255.0;
      paint.color =
          foamColor.withAlpha((opacity * baseAlpha * 255).round().clamp(0, 255));

      canvas.drawCircle(Offset(px, py), p.size, paint);
    }

    // --- Sparkle particles ---
    for (final s in sparkleParticles) {
      if (s.isDead(elapsed)) {
        s.reset(rng, elapsed);
      }

      final age = s.age(elapsed);
      final t = (age / OceanConfig.sparkleLifetime).clamp(0.0, 1.0);

      // Sharp flash: ramp up to peak at t = 0.3, then rapid fade.
      final double opacity =
          t < 0.3 ? (t / 0.3) : ((1.0 - t) / 0.7);

      final sx = (s.x + s.driftX * age) * size.width;
      final sy = horizonPixelY + s.y * waterHeight;

      final baseAlpha = sparkleColor.alpha / 255.0;
      final coreAlpha =
          (opacity * baseAlpha * 255).round().clamp(0, 255);

      // Bright core circle.
      paint.color = sparkleColor.withAlpha(coreAlpha);
      canvas.drawCircle(Offset(sx, sy), s.size * 0.5, paint);

      // Larger, softer glow halo at 30 % of the core alpha.
      final glowAlpha = (coreAlpha * 0.3).round().clamp(0, 255);
      paint.color = sparkleColor.withAlpha(glowAlpha);
      canvas.drawCircle(Offset(sx, sy), s.size, paint);
    }
  }

  /// Always repaint — the stopwatch drives continuous animation.
  @override
  bool shouldRepaint(_FoamPainter old) => true;
}
