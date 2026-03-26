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
              Colors.white.withAlpha(8),   // very faint at top
              Colors.white.withAlpha(20),  // slightly stronger
              Colors.white.withAlpha(30),  // peak in center
              Colors.white.withAlpha(20),  // ease back
              Colors.white.withAlpha(10),  // light at bottom
            ],
          ),
        ),
      ),
    );
  }
}
