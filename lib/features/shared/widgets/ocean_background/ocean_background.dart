import 'dart:async';
import 'package:flutter/material.dart';

import 'ocean_config.dart';
import 'ocean_content_overlay.dart';
import 'ocean_foam_layer.dart';
import 'ocean_shader_layer.dart';
import 'ocean_sky_gradient.dart';
import 'ocean_time_colors.dart';

/// Live animated ocean background with time-of-day awareness.
///
/// Wraps [child] in a full-bleed animated ocean scene:
/// sky gradient + wave surface + foam particles + readability overlay.
///
/// Colors shift based on the device's local time — dawn pinks, midday
/// turquoise, sunset purples, moonlit dark blue at night.
///
/// Example:
/// ```dart
/// OceanBackground(
///   child: Scaffold(
///     backgroundColor: Colors.transparent,
///     body: MyScreenContent(),
///   ),
/// )
/// ```
class OceanBackground extends StatefulWidget {
  const OceanBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<OceanBackground> createState() => _OceanBackgroundState();
}

class _OceanBackgroundState extends State<OceanBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;
  late OceanPalette _palette;
  Timer? _paletteTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _palette = OceanTimeColors.forTime(DateTime.now());
    _paletteTimer = Timer.periodic(
      OceanConfig.paletteUpdateInterval,
      (_) => _updatePalette(),
    );
  }

  void _updatePalette() {
    if (!mounted) return;
    setState(() {
      _palette = OceanTimeColors.forTime(DateTime.now());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause animation when backgrounded to save battery.
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.repeat();
      _updatePalette(); // refresh colors on resume
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _paletteTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect reduced motion accessibility setting.
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Layer 0+1: Sky + Water shader (or static fallback).
        RepaintBoundary(
          child: reduceMotion
              ? OceanSkyGradient(palette: _palette)
              : OceanShaderLayer(
                  animation: _controller,
                  palette: _palette,
                ),
        ),

        // Layer 2: Foam particles (skip if reduced motion).
        if (!reduceMotion)
          RepaintBoundary(
            child: OceanFoamLayer(
              animation: _controller,
              foamColor: _palette.foam,
              sparkleColor: _palette.sparkle,
            ),
          ),

        // Layer 3: Readability overlay.
        const OceanContentOverlay(),

        // Layer 4: App content.
        widget.child,
      ],
    );
  }
}
