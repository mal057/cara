import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages the AES-256 database encryption key lifecycle.
///
/// The key is a 32-byte cryptographically random value stored in the OS
/// hardware-backed secure storage (Android Keystore / iOS Keychain).
/// It is never held in memory longer than necessary and never leaves the
/// device.
///
/// Key lifecycle:
/// - First launch  : [generateKey] + [storeKey] called during onboarding.
/// - Subsequent    : [retrieveKey] called after successful auth.
/// - Delete data   : [deleteKey] followed by [generateKey] + [storeKey].
class EncryptionKeyManager {
  EncryptionKeyManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: _androidOptions,
          iOptions: _iosOptions,
        );

  static const String _keyStorageKey = 'cara_db_encryption_key';

  /// Android: hardware-backed AES-GCM storage via the Android Keystore.
  ///
  /// - [resetOnError] is explicitly false so a corrupt keystore never silently
  ///   destroys the encryption key — we surface the error instead.
  /// - [migrateOnAlgorithmChange] is true to survive library upgrades.
  static const AndroidOptions _androidOptions = AndroidOptions(
    resetOnError: false,
    migrateOnAlgorithmChange: true,
    keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );

  /// iOS: keychain item accessible after first device unlock (survives reboot
  /// without re-auth, required for background database access).
  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
    synchronizable: false, // never back up to iCloud
  );

  final FlutterSecureStorage _storage;

  /// Generates a cryptographically secure random 32-byte key.
  ///
  /// Uses [Random.secure] which maps to the platform's CSPRNG
  /// (`/dev/urandom` on Android/iOS). Returns a new [Uint8List] on every
  /// call; the caller is responsible for storing it via [storeKey].
  Future<Uint8List> generateKey() async {
    final random = Random.secure();
    final key = Uint8List(32);
    for (var i = 0; i < key.length; i++) {
      key[i] = random.nextInt(256);
    }
    return key;
  }

  /// Persists [key] to hardware-backed secure storage.
  ///
  /// The raw bytes are hex-encoded before storage because
  /// [FlutterSecureStorage] works exclusively with [String] values.
  /// Throws a [EncryptionKeyStorageException] if the write fails.
  Future<void> storeKey(Uint8List key) async {
    if (key.length != 32) {
      throw ArgumentError(
        'Encryption key must be exactly 32 bytes, got ${key.length}.',
      );
    }
    final hex = _bytesToHex(key);
    try {
      await _storage.write(key: _keyStorageKey, value: hex);
    } catch (e) {
      throw EncryptionKeyStorageException(
        'Failed to store encryption key in secure storage.',
        cause: e,
      );
    }
  }

  /// Reads and returns the stored encryption key, or `null` if no key exists.
  ///
  /// Throws a [EncryptionKeyStorageException] if the storage read fails or the
  /// stored value is malformed.
  Future<Uint8List?> retrieveKey() async {
    final String? hex;
    try {
      hex = await _storage.read(key: _keyStorageKey);
    } catch (e) {
      throw EncryptionKeyStorageException(
        'Failed to read encryption key from secure storage.',
        cause: e,
      );
    }

    if (hex == null) return null;

    final bytes = _hexToBytes(hex);
    if (bytes.length != 32) {
      throw EncryptionKeyStorageException(
        'Stored encryption key has unexpected length ${bytes.length}; '
        'expected 32 bytes. The key may be corrupted.',
      );
    }
    return bytes;
  }

  /// Removes the encryption key from secure storage.
  ///
  /// After calling this, the SQLCipher database is permanently inaccessible
  /// unless a new key is generated and a fresh database is created.
  /// Intended for the "Delete All Data" feature.
  ///
  /// Throws a [EncryptionKeyStorageException] if the delete fails.
  Future<void> deleteKey() async {
    try {
      await _storage.delete(key: _keyStorageKey);
    } catch (e) {
      throw EncryptionKeyStorageException(
        'Failed to delete encryption key from secure storage.',
        cause: e,
      );
    }
  }

  /// Returns `true` if an encryption key is currently stored.
  ///
  /// Used for first-run detection: if no key exists, onboarding must be
  /// completed before the database can be opened.
  ///
  /// Throws a [EncryptionKeyStorageException] if the storage query fails.
  Future<bool> hasKey() async {
    try {
      return await _storage.containsKey(key: _keyStorageKey);
    } catch (e) {
      throw EncryptionKeyStorageException(
        'Failed to check encryption key existence in secure storage.',
        cause: e,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Converts a [Uint8List] to a lowercase hexadecimal string.
  static String _bytesToHex(Uint8List bytes) {
    final buffer = StringBuffer();
    for (final byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  /// Converts a lowercase hexadecimal string back to a [Uint8List].
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

/// Thrown when a secure-storage operation fails.
class EncryptionKeyStorageException implements Exception {
  const EncryptionKeyStorageException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => cause != null
      ? 'EncryptionKeyStorageException: $message\nCause: $cause'
      : 'EncryptionKeyStorageException: $message';
}
