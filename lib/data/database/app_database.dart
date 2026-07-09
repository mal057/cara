import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

import 'migrations/schema_v1.dart';
import 'migrations/schema_v2.dart';
import 'tables/cycles_table.dart';
import 'tables/daily_notes_table.dart';
import 'tables/notification_preferences_table.dart';
import 'tables/period_logs_table.dart';
import 'tables/settings_table.dart';
import 'tables/symptom_entries_table.dart';
import 'tables/symptoms_table.dart';

part 'app_database.g.dart';

/// SQLCipher-encrypted Drift database for Cara.
///
/// All user data — cycles, period logs, symptoms, notes, settings — is stored
/// inside a single encrypted SQLite file (`cara.db`) in the app's documents
/// directory. The 32-byte AES-256 key is supplied at open time via the static
/// [connect] factory and passed directly to SQLCipher using the raw-key PRAGMA
/// (no PBKDF2 derivation, per Karla Note 4 — saves ~200 ms on cold start).
///
/// Usage:
/// ```dart
/// final key = await encryptionKeyManager.retrieveKey();
/// final db  = await AppDatabase.connect(key!);
/// ```
@DriftDatabase(tables: [
  CyclesTable,
  PeriodLogsTable,
  SymptomsTable,
  SymptomEntriesTable,
  DailyNotesTable,
  SettingsTable,
  NotificationPreferencesTable,
])
class AppDatabase extends _$AppDatabase {
  /// Internal constructor — callers must use [connect].
  AppDatabase(super.executor);

  // ---------------------------------------------------------------------------
  // Schema version & migrations
  // ---------------------------------------------------------------------------

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => SchemaV1.migrate(m, this),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await SchemaV2.migrate(m, this);
          }
        },
        beforeOpen: (details) async {
          // Enable foreign key enforcement on every connection. SQLite/SQLCipher
          // disables FK checks by default; enabling here ensures referential
          // integrity is enforced for the lifetime of this connection.
          await customStatement('PRAGMA foreign_keys = ON;');

          // Enable WAL journaling for better concurrent read performance.
          // WAL mode allows simultaneous reads while a write is in progress.
          await customStatement('PRAGMA journal_mode = WAL;');
        },
      );

  // ---------------------------------------------------------------------------
  // Factory — async because getApplicationDocumentsDirectory() is async
  // ---------------------------------------------------------------------------

  /// Opens (or creates) the encrypted Cara database.
  ///
  /// [encryptionKey] must be exactly 32 bytes — the raw AES-256 key as
  /// returned by [EncryptionKeyManager.retrieveKey]. The bytes are hex-encoded
  /// and passed to SQLCipher via `PRAGMA key = "x'<hex>'"` (raw key mode,
  /// no PBKDF2 key derivation).
  ///
  /// The database is opened on a background isolate via
  /// [NativeDatabase.createInBackground] so the main thread is never blocked
  /// by I/O or encryption overhead.
  ///
  /// Throws [ArgumentError] if [encryptionKey] is not exactly 32 bytes.
  static Future<AppDatabase> connect(Uint8List encryptionKey) async {
    if (encryptionKey.length != 32) {
      throw ArgumentError(
        'encryptionKey must be exactly 32 bytes, got ${encryptionKey.length}.',
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/cara.db');

    // Convert the raw key bytes to a 64-char lowercase hex string.
    // This is the format SQLCipher expects for the raw-key PRAGMA.
    final hexKey = _bytesToHex(encryptionKey);

    // Capture the root isolate token so the background isolate can initialize
    // platform channels (required by applyWorkaroundToOpenSqlCipherOnOldAndroidVersions).
    final token = RootIsolateToken.instance!;

    return AppDatabase(
      NativeDatabase.createInBackground(
        file,
        // isolateSetup runs on the background isolate before any database
        // operations. We initialize platform channels, apply the SQLCipher
        // workaround for old Android versions, then override the sqlite3
        // open function to load libsqlcipher instead of libsqlite3.
        isolateSetup: () async {
          BackgroundIsolateBinaryMessenger.ensureInitialized(token);
          await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
          open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
        },
        // The setup callback runs on the background isolate before Drift
        // executes any statement. We apply the key pragma here so SQLCipher
        // can decrypt the file header before the first SELECT/INSERT.
        //
        // Raw-key pragma format: PRAGMA key = "x'<64-char hex>'";
        // This bypasses PBKDF2 derivation and saves ~200 ms (Karla Note 4).
        setup: (db) {
          db.execute("PRAGMA key = \"x'$hexKey'\";");
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Closes the database and releases all resources.
  ///
  /// After this call the database must not be used again. Create a new
  /// instance via [connect] if access is required again (e.g. after the user
  /// rotates their encryption key during a data-delete flow).
  @override
  Future<void> close() => super.close();

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Converts [bytes] to a lowercase hexadecimal string.
  ///
  /// Each byte is rendered as exactly two hex characters, left-padded with
  /// a zero if necessary. The output length is always `bytes.length * 2`.
  static String _bytesToHex(Uint8List bytes) {
    final buffer = StringBuffer();
    for (final byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}
