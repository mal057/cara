import 'package:flutter/material.dart';

import 'ocean_time_colors.dart';

/// Static sky-to-ocean gradient fallback.
///
/// Displayed for ~50ms while the fragment shader compiles on first use.
/// Colors match the shader output so the transition is visually seamless.
class OceanSkyGradient extends StatelessWidget {
  const OceanSkyGradient({super.key, required this.palette});

  final OceanPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.30, 0.34, 1.0],
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
