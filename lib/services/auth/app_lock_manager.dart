import 'package:flutter/widgets.dart';

/// Manages app lock/unlock lifecycle based on background duration.
///
/// Mixes in [WidgetsBindingObserver] to receive app lifecycle events.
/// Records the time the app was paused and, on resume, checks whether
/// the elapsed duration exceeds [timeout]. If it does, [isLocked] becomes
/// `true` and callers (e.g. the auth guard) must trigger re-authentication.
///
/// Usage:
/// ```dart
/// final manager = AppLockManager();
/// WidgetsBinding.instance.addObserver(manager);
/// // later, on dispose:
/// WidgetsBinding.instance.removeObserver(manager);
/// ```
///
/// The [timeout] field defaults to 30 seconds to match experience.md
/// Journey 9.1 (< 30 s background = no re-auth) and 9.2 (> 30 s = lock).
/// Update [timeout] whenever the user changes the auto-lock setting.
class AppLockManager with WidgetsBindingObserver {
  /// Creates an [AppLockManager] with an optional [timeout] duration.
  ///
  /// Defaults to 30 seconds.  Pass a different value to reflect the
  /// user's auto-lock preference read from [SettingsDao].
  AppLockManager({this.timeout = const Duration(seconds: 30)});

  /// The inactivity duration after which the app is locked on resume.
  ///
  /// Update this field when the user changes their auto-lock setting.
  Duration timeout;

  DateTime? _pausedAt;
  bool _isLocked = false;

  // ---------------------------------------------------------------------------
  // Blueprint contract methods
  // ---------------------------------------------------------------------------

  /// Records the time at which the app entered the background.
  ///
  /// Called internally by [didChangeAppLifecycleState] on [paused],
  /// [inactive], and [hidden] states, and may also be called directly
  /// in tests.
  void onAppPaused() {
    _pausedAt = DateTime.now();
  }

  /// Checks whether the background duration exceeded [timeout].
  ///
  /// Returns `true` when the elapsed time since [onAppPaused] was called
  /// is greater than [timeout], indicating the app should be locked.
  /// Returns `false` when the app was only briefly backgrounded or when
  /// [onAppPaused] was never called (e.g. on cold start).
  ///
  /// Side-effects:
  /// - Sets [isLocked] to `true` when the timeout is exceeded.
  /// - Always clears the stored pause timestamp after evaluation.
  bool onAppResumed() {
    final pausedAt = _pausedAt;
    _pausedAt = null;

    if (pausedAt == null) {
      // No recorded pause — no lock needed.
      return false;
    }

    final elapsed = DateTime.now().difference(pausedAt);
    if (elapsed > timeout) {
      _isLocked = true;
      return true;
    }

    return false;
  }

  // ---------------------------------------------------------------------------
  // Lock state
  // ---------------------------------------------------------------------------

  /// Whether the app is currently locked and requires re-authentication.
  bool get isLocked => _isLocked;

  /// Locks the app immediately.
  ///
  /// Sets [isLocked] to `true`.  The auth guard redirects to the lock
  /// screen when this is called.
  void lock() {
    _isLocked = true;
  }

  /// Unlocks the app after successful authentication.
  ///
  /// Sets [isLocked] to `false` and clears the pause timestamp so that
  /// subsequent resumes start fresh.
  void unlock() {
    _isLocked = false;
    _pausedAt = null;
  }

  // ---------------------------------------------------------------------------
  // WidgetsBindingObserver
  // ---------------------------------------------------------------------------

  /// Responds to Flutter app lifecycle state changes.
  ///
  /// - [AppLifecycleState.paused] / [inactive] / [hidden]:
  ///   calls [onAppPaused] to record the departure time.
  /// - [AppLifecycleState.resumed]:
  ///   calls [onAppResumed] to evaluate whether the timeout was exceeded.
  ///
  /// Both `inactive` and `hidden` are included because on some platforms
  /// the transition may skip directly from `inactive` to `resumed` without
  /// passing through `paused`, so stamping on every backgrounding state
  /// ensures no resume goes unchecked.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        onAppPaused();
      case AppLifecycleState.resumed:
        onAppResumed();
      case AppLifecycleState.detached:
        // App is being terminated — no lock action needed.
        break;
    }
  }
}
