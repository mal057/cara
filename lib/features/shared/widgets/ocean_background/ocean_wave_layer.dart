import 'dart:async';
import 'package:flutter/material.dart';
import 'ocean_config.dart';
import 'ocean_time_images.dart';

/// Multi-frame crossfade wave layer for the ocean background.
///
/// Replaces the GLSL fragment shader approach with a pure-Flutter animation
/// built from pre-rendered PNG frames. Two crossfade levels work together:
///
/// **Intra-period** (wave motion): cycles through [OceanConfig.framesPerPeriod]
/// frames every [OceanConfig.frameCycleDuration], with each transition driven
/// by [AnimatedSwitcher] over [OceanConfig.frameCrossfadeDuration]. This
/// creates organic wave motion from pre-rendered frame differences.
///
/// **Inter-period** (time-of-day): when [OceanTimeImages.forTime] returns a
/// non-zero blend factor, two running frame sets are stacked with [Opacity].
/// Both share the same [_currentFrame] counter so wave animations remain
/// synchronised across periods.
///
/// The widget pauses its timer when the app is backgrounded and resumes on
/// foreground to conserve battery.
///
/// Example:
/// ```dart
/// OceanWaveLayer(currentTime: DateTime.now())
/// ```
class OceanWaveLayer extends StatefulWidget {
  const OceanWaveLayer({
    super.key,
    required this.currentTime,
  });

  /// Current local time used to determine which period images to show and
  /// the crossfade blend between adjacent periods. Updated by the parent
  /// every [OceanConfig.paletteUpdateInterval] (60 seconds).
  final DateTime currentTime;

  @override
  State<OceanWaveLayer> createState() => _OceanWaveLayerState();
}

class _OceanWaveLayerState extends State<OceanWaveLayer>
    with WidgetsBindingObserver {
  late Timer _timer;
  int _currentFrame = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(OceanConfig.frameCycleDuration, (_) {
      if (mounted) {
        setState(() {
          _currentFrame = (_currentFrame + 1) % OceanConfig.framesPerPeriod;
        });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _timer.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  Widget _buildFrameSet(OceanPeriod period) {
    return AnimatedSwitcher(
      duration: OceanConfig.frameCrossfadeDuration,
      child: Image.asset(
        OceanTimeImages.assetPath(period, _currentFrame),
        key: ValueKey<String>('${period.name}_$_currentFrame'),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (currentPeriod, nextPeriod, periodBlend) =
        OceanTimeImages.forTime(widget.currentTime);

    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Current period's cycling frames.
          // When blend == 0 we skip the Opacity wrapper entirely so Flutter
          // can skip the compositing layer and save a raster pass.
          periodBlend == 0.0
              ? _buildFrameSet(currentPeriod)
              : Opacity(
                  opacity: 1.0 - periodBlend,
                  child: _buildFrameSet(currentPeriod),
                ),

          // Next period's cycling frames — only rendered during transitions.
          if (periodBlend > 0.0)
            Opacity(
              opacity: periodBlend,
              child: _buildFrameSet(nextPeriod),
            ),
        ],
      ),
    );
  }
}
