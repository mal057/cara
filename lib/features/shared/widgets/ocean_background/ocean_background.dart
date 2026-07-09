import 'dart:async';
import 'package:flutter/material.dart';

import 'ocean_config.dart';
import 'ocean_content_overlay.dart';
import 'ocean_time_images.dart';
import 'ocean_video_layer.dart';
import 'ocean_wave_layer.dart';

/// Live animated ocean background with time-of-day awareness.
///
/// Wraps [child] in a full-bleed animated ocean scene:
/// wave frame crossfade + readability overlay.
///
/// Frame images shift based on the device's local time — dawn pinks, midday
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
    with WidgetsBindingObserver {
  Timer? _paletteTimer;
  DateTime _currentTime = OceanTimeImages.currentTime();
  bool _useVideo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _paletteTimer = Timer.periodic(
      OceanConfig.paletteUpdateInterval,
      (_) => _updateTime(),
    );
  }

  void _updateTime() {
    if (!mounted) return;
    setState(() {
      _currentTime = OceanTimeImages.currentTime();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateTime();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _paletteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect reduced motion accessibility setting.
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Layer 0: Ocean background (video → PNG fallback → static image).
        RepaintBoundary(
          child: reduceMotion
              ? _StaticImageFallback(currentTime: _currentTime)
              : _useVideo
                  ? OceanVideoLayer(
                      currentTime: _currentTime,
                      onError: () => setState(() => _useVideo = false),
                    )
                  : OceanWaveLayer(currentTime: _currentTime),
        ),

        // Layer 1: Readability overlay.
        const OceanContentOverlay(),

        // Layer 2: App content.
        widget.child,
      ],
    );
  }
}

class _StaticImageFallback extends StatelessWidget {
  const _StaticImageFallback({required this.currentTime});
  final DateTime currentTime;

  @override
  Widget build(BuildContext context) {
    final (currentPeriod, _, _) = OceanTimeImages.forTime(currentTime);
    return Image.asset(
      OceanTimeImages.assetPath(currentPeriod, 0),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
