import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/settings_table.dart';

part 'settings_dao.g.dart';

/// Data access object for the settings key-value table.
///
/// The settings table uses [key] as the primary key, so [setSetting] is a
/// simple upsert — no separate insert vs. update branching needed.
///
/// [watchSetting] uses `.distinct()` to suppress duplicate emissions when an
/// unrelated setting changes (Karla Note 7).
@DriftAccessor(tables: [SettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// Returns the stored value for [key], or null if the key does not exist.
  Future<String?> getSetting(String key) async {
    final row = await (select(settingsTable)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  /// Inserts or updates the setting identified by [key] with [value].
  ///
  /// Sets updated_at to the current UTC time on every write.
  Future<void> setSetting(String key, String value) async {
    final now = DateTime.now().toUtc().toIso8601String();
    await into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion.insert(
        key: key,
        value: value,
        updatedAt: now,
      ),
    );
  }

  /// Emits the current value for [key] and every subsequent change.
  ///
  /// Emits null when the key does not exist. Uses `.distinct()` so downstream
  /// Riverpod StreamProviders rebuild only when the value actually changes,
  /// not on every unrelated settings write (Karla Note 7).
  Stream<String?> watchSetting(String key) {
    return (select(settingsTable)
          ..where((t) => t.key.equals(key)))
        .watchSingleOrNull()
        .distinct()
        .map((row) => row?.value);
  }
}
