import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'ocean_config.dart';
import 'ocean_time_colors.dart';

/// Loads and renders the ocean water fragment shader.
///
/// Falls back to [_StaticGradientFallback] while the shader compiles
/// (~50ms on first load, cached afterward).
class OceanShaderLayer extends StatefulWidget {
  const OceanShaderLayer({
    super.key,
    required this.animation,
    required this.palette,
  });

  final Animation<double> animation;
  final OceanPalette palette;

  @override
  State<OceanShaderLayer> createState() => _OceanShaderLayerState();
}

class _OceanShaderLayerState extends State<OceanShaderLayer> {
  ui.FragmentShader? _shader;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _loadShader();
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/ocean_water.frag');
    if (mounted) {
      setState(() => _shader = program.fragmentShader());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return _StaticGradientFallback(palette: widget.palette);
    }
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (_, __) {
        return CustomPaint(
          painter: _ShaderPainter(
            shader: _shader!,
            elapsedSeconds: _stopwatch.elapsedMilliseconds / 1000.0,
            palette: widget.palette,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _ShaderPainter extends CustomPainter {
  _ShaderPainter({
    required this.shader,
    required this.elapsedSeconds,
    required this.palette,
  });

  final ui.FragmentShader shader;
  final double elapsedSeconds;
  final OceanPalette palette;

  void _setColor(int startIndex, Color color) {
    shader.setFloat(startIndex, color.red / 255.0);
    shader.setFloat(startIndex + 1, color.green / 255.0);
    shader.setFloat(startIndex + 2, color.blue / 255.0);
    shader.setFloat(startIndex + 3, color.alpha / 255.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Set uniforms in order matching the .frag file
    shader.setFloat(0, size.width);           // uResolution.x
    shader.setFloat(1, size.height);          // uResolution.y
    shader.setFloat(2, elapsedSeconds);       // uTime
    shader.setFloat(3, OceanConfig.horizonY); // uHorizonY
    _setColor(4, palette.skyTop);             // uSkyTop
    _setColor(8, palette.skyBottom);          // uSkyBottom
    _setColor(12, palette.waterFar);          // uWaterFar
    _setColor(16, palette.waterNear);         // uWaterNear
    _setColor(20, palette.sunGlow);           // uSunGlow
    _setColor(24, palette.caustic);           // uCausticColor

    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(_ShaderPainter old) => true; // repaints every frame
}

/// Static gradient fallback shown while the shader compiles.
class _StaticGradientFallback extends StatelessWidget {
  const _StaticGradientFallback({required this.palette});
  final OceanPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.32, 0.33, 1.0],
          colors: [
            palette.skyTop,
            palette.skyBottom,
            palette.waterFar,
            palette.waterNear,
          ],
        ),
      ),
    );
  }
}
