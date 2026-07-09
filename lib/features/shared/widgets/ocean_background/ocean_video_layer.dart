import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'ocean_config.dart';
import 'ocean_time_images.dart';

/// Full-bleed looping video layer for the ocean background.
///
/// Loads a period-specific MP4 from assets, loops it silently, and
/// crossfades to a new video whenever the time-of-day period changes.
/// Pauses playback while the app is backgrounded to conserve battery.
///
/// If the video fails to initialise or play, [onError] is called so the
/// parent can fall back to [OceanWaveLayer].
class OceanVideoLayer extends StatefulWidget {
  const OceanVideoLayer({
    super.key,
    required this.currentTime,
    this.onError,
  });

  final DateTime currentTime;
  final VoidCallback? onError;

  @override
  State<OceanVideoLayer> createState() => _OceanVideoLayerState();
}

class _OceanVideoLayerState extends State<OceanVideoLayer>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  OceanPeriod? _loadedPeriod;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final (period, _, _) = OceanTimeImages.forTime(widget.currentTime);
    _initController(period);
  }

  @override
  void didUpdateWidget(OceanVideoLayer old) {
    super.didUpdateWidget(old);
    final (period, _, _) = OceanTimeImages.forTime(widget.currentTime);
    if (period != _loadedPeriod) {
      _initController(period);
    }
  }

  Future<void> _initController(OceanPeriod period) async {
    final previous = _controller;

    final next = VideoPlayerController.asset(
      OceanTimeImages.videoAssetPath(period),
    );

    try {
      await next.initialize();
    } catch (_) {
      await next.dispose();
      if (!_disposed) widget.onError?.call();
      return;
    }

    if (_disposed) {
      await next.dispose();
      return;
    }

    await next.setLooping(true);
    await next.setVolume(0.0);

    try {
      await next.play();
    } catch (_) {
      await next.dispose();
      if (!_disposed) widget.onError?.call();
      return;
    }

    if (_disposed) {
      await next.dispose();
      return;
    }

    if (mounted) {
      setState(() {
        _controller = next;
        _loadedPeriod = period;
      });
    }

    await previous?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller?.play();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildVideo(VideoPlayerController controller) {
    return SizedBox.expand(
      key: ValueKey(_loadedPeriod),
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) {
      return const SizedBox.expand();
    }

    return IgnorePointer(
      child: AnimatedSwitcher(
        duration: OceanConfig.videoTransitionDuration,
        child: _buildVideo(controller),
      ),
    );
  }
}
