import 'package:drift/drift.dart';

/// Stores notification preferences — one row per notification type.
///
/// Indexes (per ned-flutter.md §3.3 — architecture spec):
///   - idx_notification_preferences_type on (type): updatePreference looks up
///     by type string. type is UNIQUE so the constraint covers point lookups,
///     but a named index is required by the architecture spec.
///
/// Rows seeded at first launch (see schema_v1.dart):
///   - 'period_approaching' — enabled=0, days_before=2
///   - 'fertile_window'     — enabled=0, days_before=0
///   - 'daily_reminder'     — enabled=0, time_of_day='21:00'
@TableIndex(name: 'idx_notification_preferences_type', columns: {#type})
class NotificationPreferencesTable extends Table {
  @override
  String get tableName => 'notification_preferences';

  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Notification type identifier: 'period_approaching', 'fertile_window',
  /// or 'daily_reminder'. NOT NULL, UNIQUE.
  TextColumn get type => text().unique()();

  /// Whether this notification type is enabled. 1 = enabled, 0 = disabled.
  /// Default 0 (off). Enforced as CHECK (enabled IN (0, 1)).
  IntColumn get enabled => integer().withDefault(const Constant(0))();

  /// HH:MM time string for the daily reminder (e.g. '21:00'). Nullable —
  /// only relevant for 'daily_reminder' type.
  TextColumn get timeOfDay => text().nullable()();

  /// Days before the predicted event to fire the notification. Nullable —
  /// only relevant for 'period_approaching' and 'fertile_window' types.
  IntColumn get daysBefore => integer().nullable()();

  /// ISO 8601 timestamp — updated on every write.
  TextColumn get updatedAt => text()();

  @override
  List<String> get customConstraints =>
      ['CHECK (enabled IN (0, 1))'];
}
