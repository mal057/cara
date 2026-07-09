abstract class OceanConfig {
  // --- Time palette transition ---
  static const Duration paletteUpdateInterval = Duration(seconds: 60);
  static const double transitionWindowMinutes = 30.0;

  // --- Frame cycling ---
  static const int framesPerPeriod = 6;
  static const Duration frameCycleDuration = Duration(seconds: 5);
  static const Duration frameCrossfadeDuration = Duration(seconds: 4);

  // --- Video ---
  static const Duration videoTransitionDuration = Duration(milliseconds: 800);
}
