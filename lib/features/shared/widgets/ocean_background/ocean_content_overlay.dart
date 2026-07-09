import 'package:flutter/material.dart';

/// Semi-transparent overlay that ensures content readability over the ocean.
///
/// Light: subtle white gradient peaking at ~12% opacity.
/// Uses a vertical linear gradient — slightly stronger in the center
/// where card content typically sits.
class OceanContentOverlay extends StatelessWidget {
  const OceanContentOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            colors: [
              Colors.white.withAlpha(150),  // stronger at top for phase banner readability
              Colors.white.withAlpha(130),  // slightly reduced
              Colors.white.withAlpha(120),  // peak in center
              Colors.white.withAlpha(100),  // ease back
              Colors.white.withAlpha(50),   // slightly reduced at bottom
            ],
          ),
        ),
      ),
    );
  }
}
