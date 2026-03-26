import 'package:flutter/material.dart';

/// Wave physics and particle configuration for the ocean background.
abstract class OceanConfig {
  // Horizon position (fraction of screen height from top)
  static const double horizonY = 0.32;

  // --- Wave layers ---
  // Wave 1: Primary swell — slow, large
  static const double wave1Period = 6.0; // seconds per cycle
  static const double wave1Amplitude = 0.018; // normalized screen height
  static const double wave1Speed = 0.15; // horizontal drift speed

  // Wave 2: Secondary swell — medium, counter-direction
  static const double wave2Period = 4.5;
  static const double wave2Amplitude = 0.012;
  static const double wave2Speed = -0.10;

  // Wave 3: Deep swell — very slow, large vertical movement
  static const double wave3Period = 8.0;
  static const double wave3Amplitude = 0.022;
  static const double wave3Speed = 0.08;

  // Wave 4: Surface ripple — fast, small
  static const double wave4Period = 3.0;
  static const double wave4Amplitude = 0.005;
  static const double wave4Speed = 0.25;

  // --- Foam particles ---
  static const int foamParticleCount = 35;
  static const double foamMinSize = 1.5;
  static const double foamMaxSize = 4.0;
  static const double foamMinLifetime = 1.2; // seconds
  static const double foamMaxLifetime = 3.0;

  // --- Sparkle particles ---
  static const int sparkleCount = 8;
  static const double sparkleMinSize = 3.0;
  static const double sparkleMaxSize = 6.0;
  static const double sparkleLifetime = 0.6;

  // --- Caustic animation ---
  static const double causticSpeed = 0.08;
  static const double causticScale = 4.0;
  static const double causticIntensity = 0.15;

  // --- Time palette transition ---
  static const Duration paletteUpdateInterval = Duration(seconds: 60);
  static const double transitionWindowMinutes = 30.0; // blend over 30 mins at boundaries
}
