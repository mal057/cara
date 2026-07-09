import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
/// Manages PIN creation and verification for the Cara app lock screen.
///
/// PINs are never stored in plaintext. A cryptographically random 16-byte
/// salt is generated at [setPin] time; the PIN string code units are
/// concatenated with the salt bytes and hashed with SHA-256. Both the
/// resulting hash and the salt are persisted in hardware-backed secure storage.
///
/// PIN lifecycle:
/// - First launch  : [setPin] called during onboarding PIN setup.
/// - Auth          : [verifyPin] called on lock screen entry.
/// - Change PIN    : call [verifyPin] first, then [setPin] with the new PIN.
/// - Delete data   : [deletePin] removes both hash and salt.
class PinManager {
  PinManager({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: _androidOptions,
              iOptions: _iosOptions,
            );

  static const String _hashStorageKey = 'cara_pin_hash';
  static const String _saltStorageKey = 'cara_pin_salt';

  /// Salt length in bytes. 16 bytes = 128 bits of entropy.
  static const int _saltLength = 16;

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

  final FlutterSecureStorage _storage;

  // -------------------------------------------------------------------------
  // Public API
  // -------------------------------------------------------------------------

  /// Creates or replaces the PIN.
  ///
  /// Generates a fresh cryptographically random 16-byte salt, derives
  /// SHA-256(pin_bytes + salt), and persists both the hash and salt to
  /// hardware-backed secure storage. Any previously stored PIN is overwritten.
  ///
  /// Throws a [PinStorageException] if the secure storage write fails.
  Future<void> setPin(String pin) async {
    if (pin.isEmpty) {
      throw ArgumentError('PIN must not be empty.');
    }

    final salt = _generateSalt();
    final hash = _hashPin(pin, salt);
    final saltHex = _bytesToHex(salt);
    final hashHex = _bytesToHex(hash);

    try {
      await _storage.write(key: _saltStorageKey, value: saltHex);
      await _storage.write(key: _hashStorageKey, value: hashHex);
    } catch (e) {
      throw PinStorageException(
        'Failed to store PIN in secure storage.',
        cause: e,
      );
    }
  }

  /// Returns true if [pin] matches the stored PIN hash, false otherwise.
  ///
  /// Performs a constant-time comparison via [_secureCompare] to avoid
  /// timing side-channels. Returns false when no PIN is set.
  ///
  /// Throws a [PinStorageException] if the secure storage read fails.
  Future<bool> verifyPin(String pin) async {
    final String? saltHex;
    final String? storedHashHex;

    try {
      saltHex = await _storage.read(key: _saltStorageKey);
      storedHashHex = await _storage.read(key: _hashStorageKey);
    } catch (e) {
      throw PinStorageException(
        'Failed to read PIN data from secure storage.',
        cause: e,
      );
    }

    if (saltHex == null || storedHashHex == null) {
      return false;
    }

    final Uint8List salt;
    final Uint8List storedHash;
    try {
      salt = _hexToBytes(saltHex);
      storedHash = _hexToBytes(storedHashHex);
    } on FormatException catch (e) {
      throw PinStorageException(
        'Stored PIN data is malformed and cannot be decoded.',
        cause: e,
      );
    }

    final candidateHash = _hashPin(pin, salt);
    return _secureCompare(candidateHash, storedHash);
  }

  /// Returns true if a PIN hash is currently stored in secure storage.
  ///
  /// Used for first-run detection: if no PIN exists, the onboarding PIN setup
  /// screen must be shown before the app can be used.
  ///
  /// Throws a [PinStorageException] if the storage query fails.
  Future<bool> hasPin() async {
    try {
      return await _storage.containsKey(key: _hashStorageKey);
    } catch (e) {
      throw PinStorageException(
        'Failed to check PIN existence in secure storage.',
        cause: e,
      );
    }
  }

  /// Removes both the PIN hash and salt from secure storage.
  ///
  /// Called as part of the Delete All Data flow. After this call [hasPin]
  /// returns false and [verifyPin] returns false for any input.
  ///
  /// Throws a [PinStorageException] if either delete operation fails.
  Future<void> deletePin() async {
    try {
      await _storage.delete(key: _hashStorageKey);
      await _storage.delete(key: _saltStorageKey);
    } catch (e) {
      throw PinStorageException(
        'Failed to delete PIN data from secure storage.',
        cause: e,
      );
    }
  }

  // -------------------------------------------------------------------------
  // Private helpers
  // -------------------------------------------------------------------------

  /// Generates a cryptographically secure random [_saltLength]-byte salt.
  static Uint8List _generateSalt() {
    final random = Random.secure();
    final salt = Uint8List(_saltLength);
    for (var i = 0; i < salt.length; i++) {
      salt[i] = random.nextInt(256);
    }
    return salt;
  }

  /// Hashes [pin] with [salt] using SHA-256.
  ///
  /// The PIN is encoded as UTF-16 code units (Dart String.codeUnits) and the
  /// salt bytes are appended before hashing, ensuring hashes are unique per
  /// PIN+salt pair.
  static Uint8List _hashPin(String pin, Uint8List salt) {
    final pinBytes = Uint8List.fromList(pin.codeUnits);
    final input = Uint8List(pinBytes.length + salt.length)
      ..setRange(0, pinBytes.length, pinBytes)
      ..setRange(pinBytes.length, pinBytes.length + salt.length, salt);
    final digest = sha256.convert(input);
    return Uint8List.fromList(digest.bytes);
  }

  /// Compares two [Uint8List] values in constant time to prevent timing attacks.
  static bool _secureCompare(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }

  /// Converts a [Uint8List] to a lowercase hexadecimal string.
  static String _bytesToHex(Uint8List bytes) {
    final buffer = StringBuffer();
    for (final byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  /// Converts a lowercase hexadecimal string back to a [Uint8List].
  ///
  /// Throws a [FormatException] if [hex] has an odd length.
  static Uint8List _hexToBytes(String hex) {
    if (hex.length.isOdd) {
      throw FormatException('Hex string has odd length: ${hex.length}');
    }
    final bytes = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return bytes;
  }
}

/// Thrown when a secure-storage operation for PIN data fails.
class PinStorageException implements Exception {
  const PinStorageException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => cause != null
      ? 'PinStorageException: $message\nCause: $cause'
      : 'PinStorageException: $message';
}
