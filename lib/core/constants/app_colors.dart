import 'package:flutter/material.dart';

/// All color constants for the Sola app.
///
/// Use these instead of raw Color literals anywhere in the codebase.
abstract class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF6B4C9A); // Deep sunset purple — richest violet in the sky
  static const Color secondary = Color(0xFFE07A6B); // Warm coral-salmon from the sunset horizon

  // Background / surface
  static const Color background = Color(0xFFF3EEF5); // Soft lavender-cream — pink sand
  static const Color surface = Color(0xFFFDFBFF); // Warm white with faintest lavender tint

  // Text
  static const Color textPrimary = Color(0xFF2D2540); // Deep purple-charcoal — twilight sky
  static const Color textSecondary = Color(0xFF8A8199); // Muted lavender-gray — distant clouds

  // Semantic
  static const Color error = Color(0xFFD4503D); // Warm coral-red — sunset fire
  static const Color success = Color(0xFF3DA08C); // Ocean teal-green — turquoise water

  // Cycle phase colors (solid)
  static const Color menstrual = Color(0xFFE07A6B); // Sunset coral — warm glow at the horizon
  static const Color follicular = Color(0xFF3DB8A8); // Ocean teal — turquoise water
  static const Color ovulatory = Color(0xFFEDAE5E); // Golden sunset — amber light
  static const Color luteal = Color(0xFF9B7EC4); // Lavender sky — purple cloud tones

  // Cycle phase colors (predicted — lighter versions)
  static const Color menstrualPredicted = Color(0xFFF0B8B2); // Pale coral blush
  static const Color follicularPredicted = Color(0xFF9ADDD6); // Pale ocean mist
  static const Color ovulatoryPredicted = Color(0xFFF6D9A8); // Soft amber haze
  static const Color lutealPredicted = Color(0xFFC8B3E2); // Pale lavender cloud

  // Dark theme overrides
  static const Color darkBackground = Color(0xFF0E0B1A); // Deep ocean at night — very dark purple-black
  static const Color darkSurface = Color(0xFF1E1A2E); // Moonlit water — dark indigo
  static const Color darkTextPrimary = Color(0xFFF0EBF8); // Moonlit lavender-white
  static const Color darkTextSecondary = Color(0xFF9B93B2); // Distant lavender shore

  // Dividers / borders
  static const Color divider = Color(0xFFDDD7E4); // Soft lavender sand
  static const Color inputBorder = Color(0xFFBEB6CC); // Shell edge — deeper lavender

  // Overlay / scrim
  static const Color scrim = Color(0x80000000); // 50% black

  // Dark theme outline / divider
  static const Color darkOutline = Color(0xFF3A3050); // Deep purple water edge
  static const Color darkDivider = Color(0xFF2A2440); // Submerged twilight
}
