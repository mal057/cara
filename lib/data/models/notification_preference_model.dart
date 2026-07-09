import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preference_model.freezed.dart';

/// App-level model for a notification preference row.
///
/// Maps from a [NotificationPreferencesTable] row. One row per notification
/// type: 'period_approaching', 'fertile_window', 'daily_reminder'.
@freezed
abstract class NotificationPreferenceModel
    with _$NotificationPreferenceModel {
  const factory NotificationPreferenceModel({
    /// Database row ID from notification_preferences table.
    required int id,

    /// Notification type identifier. One of: 'period_approaching',
    /// 'fertile_window', 'daily_reminder'.
    required String type,

    /// Whether this notification type is currently enabled.
    required bool enabled,

    /// HH:MM time string for the daily reminder (e.g. '21:00').
    /// Null for non-daily types.
    String? timeOfDay,

    /// Days before the predicted event to fire the notification.
    /// Null for 'daily_reminder' type.
    int? daysBefore,

    /// When this row was last updated.
    required DateTime updatedAt,
  }) = _NotificationPreferenceModel;
}
