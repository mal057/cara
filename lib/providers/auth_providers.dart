import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../services/auth/app_lock_manager.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/encryption_key_manager.dart';
import '../services/auth/pin_manager.dart';

// ---------------------------------------------------------------------------
// Service singletons
// ---------------------------------------------------------------------------

/// Provides the singleton [EncryptionKeyManager].
final encryptionKeyManagerProvider = Provider<EncryptionKeyManager>((ref) {
  return EncryptionKeyManager();
});

/// Provides the singleton [PinManager].
final pinManagerProvider = Provider<PinManager>((ref) {
  return PinManager();
});

/// Provides the singleton [AuthService].
///
/// Wired with the same [PinManager] and [EncryptionKeyManager] instances so all
/// secure-storage reads share a single keychain namespace.
final authServiceProvider = Provider<AuthService>((ref) {
  final pinManager = ref.read(pinManagerProvider);
  final encryptionKeyManager = ref.read(encryptionKeyManagerProvider);
  return AuthService(
    pinManager: pinManager,
    encryptionKeyManager: encryptionKeyManager,
  );
});

/// Provides the singleton [AppLockManager].
///
/// The caller (typically [app.dart]) is responsible for registering this with
/// [WidgetsBinding.instance.addObserver] so lifecycle events are received.
final appLockManagerProvider = Provider<AppLockManager>((ref) {
  return AppLockManager();
});

// ---------------------------------------------------------------------------
// Auth state
// ---------------------------------------------------------------------------

/// Represents the three dimensions of authentication state used by the GoRouter
/// auth guard and the app initial routing decision.
class AuthState {
  const AuthState({
    this.isAuthenticated = false,
    this.isOnboardingComplete = false,
    this.isLocked = false,
  });

  /// True after the user passes PIN or biometric verification in this session.
  final bool isAuthenticated;

  /// True after onboarding (PIN setup) has been completed at least once.
  final bool isOnboardingComplete;

  /// True when the app is locked due to timeout or an explicit lock call.
  final bool isLocked;

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isOnboardingComplete,
    bool? isLocked,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  String toString() =>
      'AuthState(isAuthenticated: $isAuthenticated, '
      'isOnboardingComplete: $isOnboardingComplete, '
      'isLocked: $isLocked)';
}

/// Manages [AuthState] for the entire app session.
///
/// On construction, asynchronously checks [AuthService.isOnboardingComplete]
/// and seeds [state]. UI mutations are performed via the public methods.
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._authService) : super(const AuthState()) {
    _init();
  }

  final AuthService _authService;

  Future<void> _init() async {
    final onboarded = await _authService.isOnboardingComplete();
    state = state.copyWith(isOnboardingComplete: onboarded);
  }

  /// Attempts biometric-first authentication (falls back to PIN if not
  /// available or after 3 failures). Returns true on success.
  Future<bool> authenticate() async {
    final success = await _authService.authenticate();
    if (success) {
      state = state.copyWith(isAuthenticated: true, isLocked: false);
    }
    return success;
  }

  /// Verifies [pin] against the stored PIN hash. Updates state on success.
  Future<bool> authenticateWithPin(String pin) async {
    final success = await _authService.authenticateWithPin(pin);
    if (success) {
      state = state.copyWith(isAuthenticated: true, isLocked: false);
    }
    return success;
  }

  /// Prompts the device biometric sensor. Updates state on success.
  Future<bool> authenticateWithBiometric() async {
    final success = await _authService.authenticateWithBiometric();
    if (success) {
      state = state.copyWith(isAuthenticated: true, isLocked: false);
    }
    return success;
  }

  /// Marks onboarding complete after PIN setup. Sets session as authenticated.
  void completeOnboarding() {
    state = state.copyWith(isOnboardingComplete: true, isAuthenticated: true);
  }

  /// Locks the app session. GoRouter auth guard redirects to /lock.
  void lock() {
    _authService.lockApp();
    state = state.copyWith(isAuthenticated: false, isLocked: true);
  }

  /// Unlocks the app session without re-authenticating.
  ///
  /// Call this after the authentication screen has already verified credentials.
  void unlock() {
    _authService.unlockApp();
    state = state.copyWith(isAuthenticated: true, isLocked: false);
  }
}

/// Exposes [AuthState] to the widget tree.
///
/// Used by [app_router.dart] for initial routing and authentication redirects.
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthStateNotifier(authService);
});
