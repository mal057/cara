/// All spacing, radius, and dimension constants for the Cara app.
///
/// All touch targets are at least 44 dp to meet WCAG accessibility guidelines.
abstract class AppSizes {
  // -------------------------------------------------------------------
  // Spacing scale (8dp base grid)
  // -------------------------------------------------------------------

  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;

  // -------------------------------------------------------------------
  // Semantic spacing aliases
  // -------------------------------------------------------------------

  /// Standard horizontal page padding.
  static const double pagePadding = 16.0;

  /// Padding inside cards and sections.
  static const double cardPadding = 16.0;

  /// Gap between major sections on a screen.
  static const double sectionGap = 24.0;

  /// Gap between items in a list or grid.
  static const double itemGap = 12.0;

  /// Small gap between tightly related elements (e.g., icon + label).
  static const double tinyGap = 4.0;

  // -------------------------------------------------------------------
  // Border radius
  // -------------------------------------------------------------------

  /// Very small radius — chips, badges, tags.
  static const double radiusSmall = 6.0;

  /// Standard card radius.
  static const double radiusCard = 12.0;

  /// Dialog and bottom sheet radius.
  static const double radiusLarge = 20.0;

  /// Pill / fully-rounded elements.
  static const double radiusPill = 100.0;

  // -------------------------------------------------------------------
  // Touch targets (minimum 44dp for accessibility)
  // -------------------------------------------------------------------

  /// Minimum touch target per WCAG 2.5.5.
  static const double touchTarget = 44.0;

  /// Standard button height.
  static const double buttonHeight = 52.0;

  /// Height of a settings tile row.
  static const double settingsTileHeight = 56.0;

  /// Height of the bottom navigation bar.
  static const double bottomNavHeight = 64.0;

  // -------------------------------------------------------------------
  // Icon sizes
  // -------------------------------------------------------------------

  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // -------------------------------------------------------------------
  // Calendar
  // -------------------------------------------------------------------

  /// Height of each calendar day cell.
  static const double calendarDaySize = 40.0;

  /// Dot indicator diameter for days with symptoms.
  static const double symptomDotSize = 6.0;

  // -------------------------------------------------------------------
  // PIN pad
  // -------------------------------------------------------------------

  /// Diameter of a PIN dot indicator circle.
  static const double pinDotSize = 14.0;

  /// Diameter of each PIN pad key.
  static const double pinKeySize = 72.0;

  // -------------------------------------------------------------------
  // Elevation
  // -------------------------------------------------------------------

  static const double elevationCard = 2.0;
  static const double elevationSheet = 8.0;
  static const double elevationDialog = 16.0;

  // -------------------------------------------------------------------
  // Animation durations (ms)
  // -------------------------------------------------------------------

  /// Fast micro-interactions (ripples, chip highlights).
  static const int animFast = 150;

  /// Standard transitions (route changes, modals).
  static const int animStandard = 250;

  /// Slow reveals (onboarding cards, confetti).
  static const int animSlow = 400;
}
