import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/notification_preferences_table.dart';
import '../../models/notification_preference_model.dart';

part 'notification_dao.g.dart';

/// Data access object for the notification_preferences table.
///
/// One row per notification type ('period_approaching', 'fertile_window',
/// 'daily_reminder'). Rows are seeded at first launch by [SchemaV1].
@DriftAccessor(tables: [NotificationPreferencesTable])
class NotificationDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationDaoMixin {
  NotificationDao(super.db);

  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  /// Returns all notification preference rows (typically 3 rows).
  Future<List<NotificationPreferenceModel>> getPreferences() async {
    final rows = await select(notificationPreferencesTable).get();
    return rows.map(_rowToModel).toList();
  }

  /// Updates the notification preference row matching [type].
  ///
  /// Only the fields provided in [pref] companion are written; absent fields
  /// keep their existing values. Sets updated_at to the current UTC time.
  ///
  /// [type] must be one of 'period_approaching', 'fertile_window',
  /// 'daily_reminder' — validated by the database UNIQUE constraint.
  Future<void> updatePreference(
    String type,
    NotificationPreferencesTableCompanion pref,
  ) async {
    await (update(notificationPreferencesTable)
          ..where((t) => t.type.equals(type)))
        .write(pref);
  }

  // ---------------------------------------------------------------------------
  // Mapper
  // ---------------------------------------------------------------------------

  NotificationPreferenceModel _rowToModel(
    NotificationPreferencesTableData row,
  ) {
    return NotificationPreferenceModel(
      id: row.id,
      type: row.type,
      enabled: row.enabled == 1,
      timeOfDay: row.timeOfDay,
      daysBefore: row.daysBefore,
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }
}
