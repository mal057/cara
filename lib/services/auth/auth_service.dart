import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import 'encryption_key_manager.dart';
import 'pin_manager.dart';

/// Coordinates biometric and PIN authentication for the Sola app.
///
/// AuthService is the single security gatekeeper for the application.
/// It enforces that [getEncryptionKey] is only accessible after a successful
/// [authenticate] or [authenticateWithPin] / [authenticateWithBiometric] call.
///
/// Auth flow:
/// 1. Cold start: [isOnboardingComplete] -> if false, show onboarding.
/// 2. Lock screen: [authenticate] -> biometric (if enabled + available),
///    falls back to PIN after [_maxBiometricAttempts] consecutive failures.
/// 3. After success: [getEncryptionKey] returns the database key.
/// 4. Settings reset: [deleteAllData] wipes PIN + encryption key.
class AuthService {
  AuthService({
    PinManager? pinManager,
    EncryptionKeyManager? encryptionKeyManager,
    LocalAuthentication? localAuth,
    FlutterSecureStorage? storage,
  })  : _pinManager = pinManager ?? PinManager(),
        _encryptionKeyManager =
            encryptionKeyManager ?? EncryptionKeyManager(),
        _localAuth = localAuth ?? LocalAuthentication(),
        _storage = storage ??
            const FlutterSecureStorage(
              aOptions: _androidOptions,
              iOptions: _iosOptions,
            );

  final PinManager _pinManager;
  final EncryptionKeyManager _encryptionKeyManager;
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _storage;

  static const String _biometricEnabledKey = 'sola_biometric_enabled';

  static const AndroidOptions _androidOptions = AndroidOptions(
    resetOnError: false,
    migrateOnAlgorithmChange: true,
    keyCipherAlgorithm:
        KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );

  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
    synchronizable: false,
  );

  static const int _maxBiometricAttempts = 3;

  bool _isAuthenticated = false;
  int _biometricFailureCount = 0;

  // Authentication

  /// Attempts biometric authentication using the device biometric sensor.
  ///
  /// Returns [true] on success and marks the session as authenticated.
  /// Returns [false] if biometric auth is unavailable, not enrolled, or
  /// the user cancels/fails the prompt.
  /// On success, biometric failure count resets. On failure, it increments.
  Future<bool> authenticateWithBiometric() async {
    final available = await isBiometricAvailable();
    if (!available) {
      return false;
    }

    bool success = false;
    try {
      success = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access Sola',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        sensitiveTransaction: true,
      );
    } catch (_) {
      success = false;
    }

    if (success) {
      _biometricFailureCount = 0;
      _isAuthenticated = true;
    } else {
      _biometricFailureCount++;
    }
    return success;
  }

  /// Verifies [pin] against the stored PIN hash via [PinManager.verifyPin].
  ///
  /// Returns [true] on success and marks the session as authenticated.
  /// Returns [false] if the PIN does not match or no PIN is set.
  Future<bool> authenticateWithPin(String pin) async {
    final verified = await _pinManager.verifyPin(pin);
    if (verified) {
      _isAuthenticated = true;
      _biometricFailureCount = 0;
    }
    return verified;
  }

  /// Primary authentication entry point.
  ///
  /// If biometric is enabled, available, and under the failure cap:
  /// attempt biometric. Otherwise return [false] so caller shows PIN UI.
  /// After [_maxBiometricAttempts] failures, [shouldShowPinFallback] is true.
  Future<bool> authenticate() async {
    final biometricEnabled = await isBiometricEnabled();
    final biometricAvailable = await isBiometricAvailable();

    if (biometricEnabled &&
        biometricAvailable &&
        _biometricFailureCount < _maxBiometricAttempts) {
      return authenticateWithBiometric();
    }

    return false;
  }

  // Onboarding & setup

  /// Returns [true] if onboarding is complete (a PIN has been set).
  ///
  /// A stored PIN is the canonical first-run indicator.
  Future<bool> isOnboardingComplete() async {
    return _pinManager.hasPin();
  }

  /// Sets up the initial PIN and generates the database encryption key.
  ///
  /// Called exactly once during onboarding. Generates a 32-byte key,
  /// stores it, sets the PIN, and marks the session as authenticated.
  ///
  /// Throws [ArgumentError] if [pin] is empty.
  /// Throws [PinStorageException] or [EncryptionKeyStorageException] on failure.
  Future<void> setupPin(String pin) async {
    if (pin.isEmpty) {
      throw ArgumentError('PIN must not be empty.');
    }
    final key = await _encryptionKeyManager.generateKey();
    await _encryptionKeyManager.storeKey(key);
    await _pinManager.setPin(pin);
    _isAuthenticated = true;
  }

  /// Changes the PIN after verifying the current PIN.
  ///
  /// Verifies [oldPin] first; throws [ArgumentError] if it does not match.
  /// The method name preserves the blueprint contract (capital I in PIn).
  Future<void> changePIn(String oldPin, String newPin) async {
    if (newPin.isEmpty) {
      throw ArgumentError('New PIN must not be empty.');
    }
    final verified = await _pinManager.verifyPin(oldPin);
    if (!verified) {
      throw ArgumentError('Current PIN is incorrect.');
    }
    await _pinManager.setPin(newPin);
  }

  // Encryption key access

  /// Returns the database encryption key, gated behind authentication.
  ///
  /// Throws [AuthenticationRequiredException] if not authenticated.
  /// Returns null if no key exists yet (pre-onboarding -- should not
  /// occur in production after [setupPin] completes).
  Future<Uint8List?> getEncryptionKey() async {
    if (!_isAuthenticated) {
      throw AuthenticationRequiredException(
        'Cannot retrieve encryption key: user is not authenticated.',
      );
    }
    return _encryptionKeyManager.retrieveKey();
  }

  // Biometric management

  /// Returns [true] if the device has biometric hardware and enrolled
  /// credentials, as reported by [LocalAuthentication].
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) return false;
      final enrolled = await _localAuth.getAvailableBiometrics();
      return enrolled.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Returns [true] if the user has opted in to biometric authentication.
  ///
  /// Preference is persisted in hardware-backed secure storage.
  /// Defaults to [false] when no value has been written.
  Future<bool> isBiometricEnabled() async {
    try {
      final value = await _storage.read(key: _biometricEnabledKey);
      return value == 'true';
    } catch (_) {
      return false;
    }
  }

  /// Enables biometric authentication and saves the user preference.
  ///
  /// Prompts the user to confirm via biometric before saving. Returns
  /// [true] on success, [false] if unavailable or prompt declined.
  /// Throws [AuthServiceStorageException] if the preference cannot be saved.
  Future<bool> enableBiometric() async {
    final available = await isBiometricAvailable();
    if (!available) return false;

    bool confirmed = false;
    try {
      confirmed = await _localAuth.authenticate(
        localizedReason: 'Confirm biometric to enable for Sola',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
        sensitiveTransaction: true,
      );
    } catch (_) {
      return false;
    }

    if (!confirmed) return false;

    try {
      await _storage.write(key: _biometricEnabledKey, value: 'true');
    } catch (e) {
      throw AuthServiceStorageException(
        'Failed to save biometric preference.',
        cause: e,
      );
    }
    return true;
  }

  /// Disables biometric authentication by removing the stored preference.
  ///
  /// Throws [AuthServiceStorageException] if the preference cannot be removed.
  Future<void> disableBiometric() async {
    try {
      await _storage.delete(key: _biometricEnabledKey);
    } catch (e) {
      throw AuthServiceStorageException(
        'Failed to remove biometric preference.',
        cause: e,
      );
    }
  }

  // Session lock state

  /// Whether the current session is authenticated.
  bool get isAuthenticated => _isAuthenticated;

  /// Whether the session is locked (not authenticated).
  bool get isLocked => !_isAuthenticated;

  /// The number of consecutive biometric authentication failures.
  int get biometricFailureCount => _biometricFailureCount;

  /// Returns [true] when [shouldShowPinFallback] should be shown to the user.
  bool get shouldShowPinFallback =>
      _biometricFailureCount >= _maxBiometricAttempts;

  /// Locks the app session.
  ///
  /// After this call, [getEncryptionKey] throws until re-authentication.
  /// Biometric failure count resets so the prompt is fresh next time.
  void lockApp() {
    _isAuthenticated = false;
    _biometricFailureCount = 0;
  }

  /// Marks the session as authenticated.
  ///
  /// Prefer [authenticate], [authenticateWithBiometric], or
  /// [authenticateWithPin] over calling this directly.
  void unlockApp() {
    _isAuthenticated = true;
  }

  // Data deletion

  /// Permanently deletes all auth credentials and the encryption key.
  ///
  /// After this call: [isOnboardingComplete] returns false, the SQLCipher
  /// database is inaccessible, and [getEncryptionKey] throws.
  /// Used by the 'Delete All Data' settings flow.
  Future<void> deleteAllData() async {
    await _pinManager.deletePin();
    await _encryptionKeyManager.deleteKey();
    try {
      await _storage.delete(key: _biometricEnabledKey);
    } catch (_) {
      // Biometric pref may not exist; ignore.
    }
    _isAuthenticated = false;
    _biometricFailureCount = 0;
  }
}

/// Thrown when [AuthService.getEncryptionKey] is called without a valid
/// authenticated session.
class AuthenticationRequiredException implements Exception {
  const AuthenticationRequiredException(this.message);

  final String message;

  @override
  String toString() => 'AuthenticationRequiredException: $message';
}

/// Thrown when a secure-storage operation within [AuthService] fails.
class AuthServiceStorageException implements Exception {
  const AuthServiceStorageException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => cause != null
      ? 'AuthServiceStorageException: $message\nCause: $cause'
      : 'AuthServiceStorageException: $message';
}