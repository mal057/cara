/// Canonical route path constants for the Cara app.
///
/// All [GoRouter] route definitions and [context.go] / [context.push] call
/// sites MUST use these constants so that a single rename propagates
/// everywhere and static analysis catches any drift.
///
/// Blueprint contract — task FLUTTER 4.1:
///   /onboarding           -> OnboardingScreen
///   /onboarding/pin       -> PinSetupScreen
///   /onboarding/biometric -> BiometricSetupScreen
///   /onboarding/cycle     -> CycleSetupScreen
///   /lock                 -> LockScreen
///   /calendar             -> CalendarScreen (tab)
///   /log                  -> LogScreen (tab)
///   /insights             -> InsightsScreen (tab)
///   /settings             -> SettingsScreen (tab)
///   /settings/export      -> ExportScreen
///   /settings/privacy     -> PrivacyPolicyScreen
abstract class RouteNames {
  RouteNames._();

  // ---------------------------------------------------------------------------
  // Onboarding flow (linear wizard, outside ShellRoute)
  // ---------------------------------------------------------------------------

  /// Entry point for first-run onboarding.
  static const String onboarding = '/onboarding';

  /// PIN creation step within onboarding.
  static const String pinSetup = '/onboarding/pin';

  /// Biometric opt-in step within onboarding (skippable).
  static const String biometricSetup = '/onboarding/biometric';

  /// Cycle-length setup step within onboarding (skippable).
  static const String cycleSetup = '/onboarding/cycle';

  // ---------------------------------------------------------------------------
  // Auth (lock screen, outside ShellRoute)
  // ---------------------------------------------------------------------------

  /// Full-screen lock screen shown on cold start (post-onboarding) and after
  /// auto-lock timeout.
  static const String lock = '/lock';

  // ---------------------------------------------------------------------------
  // Main tabs (wrapped by StatefulShellRoute with CaraBottomNav)
  // ---------------------------------------------------------------------------

  /// Calendar tab — cycle overview, month navigation.
  static const String calendar = '/calendar';

  /// Log tab — quick entry for today's data.
  static const String log = '/log';

  /// Insights tab — cycle statistics and predictions.
  static const String insights = '/insights';

  /// Settings tab — preferences, security, data management.
  static const String settings = '/settings';

  // ---------------------------------------------------------------------------
  // Settings sub-screens (pushed on top of the shell)
  // ---------------------------------------------------------------------------

  /// CSV / PDF export screen.
  static const String export_ = '/settings/export';

  /// In-app privacy policy screen.
  static const String privacyPolicy = '/settings/privacy';
}
