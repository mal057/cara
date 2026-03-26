import 'package:drift/drift.dart';

/// Key-value store for application settings.
///
/// Uses a text primary key (the setting key) — no separate id column.
/// This table has a small, bounded row count (< 20 rows) so no additional
/// indexes are needed beyond the primary key.
///
/// Default settings seeded at first launch (see schema_v1.dart):
///   - default_cycle_length   = '28'
///   - default_period_length  = '5'
///   - auto_lock_timeout_seconds = '30'
///   - onboarding_complete    = 'false'
class SettingsTable extends Table {
  @override
  String get tableName => 'settings';

  @override
  Set<Column> get primaryKey => {key};

  /// Setting key (e.g. 'default_cycle_length'). Primary key — NOT NULL.
  TextColumn get key => text()();

  /// Setting value, JSON-encoded string. NOT NULL.
  TextColumn get value => text()();

  /// ISO 8601 timestamp — updated on every write.
  TextColumn get updatedAt => text()();
}
