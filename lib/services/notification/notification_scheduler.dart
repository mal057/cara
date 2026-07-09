import 'package:flutter/material.dart';

import '../../data/models/cycle_prediction_model.dart';
import '../../data/models/notification_preference_model.dart';
import 'notification_service.dart';

/// Notification type identifiers -- must match the values seeded into the
/// notification_preferences table by schema_v1.dart.
const String kNotificationTypePeriodApproaching = 'period_approaching';
const String kNotificationTypeFertileWindow = 'fertile_window';
const String kNotificationTypeDailyReminder = 'daily_reminder';

/// Unique notification IDs for each notification type.
///
/// Passed to [NotificationService] and stable so rescheduled notifications
/// correctly replace previously scheduled ones of the same type.
const int kNotificationIdPeriodApproaching = 1000;
const int kNotificationIdFertileWindow = 2000;
const int kNotificationIdDailyReminder = 3000;

/// Notification copy -- exact strings from experience.md section 6.
const String _kPeriodApproachingTitle = 'Period Reminder';
const String _kFertileWindowTitle = 'Fertile Window';
const String _kDailyReminderTitle = 'Daily Check-In';
const String _kDailyReminderBody = 'How was your day? Tap to log';

/// Orchestrates prediction-based and recurring notification scheduling.
///
/// [NotificationScheduler] is the single point of coordination for deciding
/// *when* and *whether* to schedule a notification. All low-level plugin
/// calls are delegated to [NotificationService].
///
/// Notification IDs (stable constants):
/// - 1000: period_approaching -- 2 days before predictedStart, at 09:00 local
/// - 2000: fertile_window -- on fertileWindowStart, at 09:00 local
/// - 3000: daily_reminder -- recurring daily at user-configured time
///
/// Always call [rescheduleAll] after cycle data or preference changes. It
/// cancels all existing notifications first to prevent duplicates.
class NotificationScheduler {
  NotificationScheduler({required NotificationService notificationService})
    : _service = notificationService;

  final NotificationService _service;

  // -------------------------------------------------------------------------
  // Public API
  // -------------------------------------------------------------------------

  /// Schedules a period-approaching notification [pref.daysBefore] days before
  /// [prediction.predictedStart], firing at 09:00 local time.
  ///
  /// Silently skips scheduling if the trigger time is already in the past.
  Future<void> schedulePeriodApproaching(
    CyclePredictionModel prediction,
    NotificationPreferenceModel pref,
  ) async {
    final daysBefore = pref.daysBefore ?? 2;
    final notificationDate = prediction.predictedStart.subtract(
      Duration(days: daysBefore),
    );
    final triggerTime = DateTime(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      9,
      0,
    );
    if (triggerTime.isBefore(DateTime.now())) return;
    await _service.scheduleNotification(
      kNotificationIdPeriodApproaching,
      _kPeriodApproachingTitle,
      'Your period may start in about $daysBefore days',
      triggerTime,
    );
  }

  /// Schedules a fertile-window notification [pref.daysBefore] days before
  /// [prediction.fertileWindowStart], firing at 09:00 local time.
  ///
  /// Silently skips if the trigger time is already in the past.
  Future<void> scheduleFertileWindow(
    CyclePredictionModel prediction,
    NotificationPreferenceModel pref,
  ) async {
    final daysBefore = pref.daysBefore ?? 0;
    final baseDate = prediction.fertileWindowStart.subtract(
      Duration(days: daysBefore),
    );
    final triggerTime = DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      9,
      0,
    );
    if (triggerTime.isBefore(DateTime.now())) return;
    final bodyText = daysBefore > 0
        ? 'Your fertile window may start in about $daysBefore days'
        : 'You may be entering your fertile window';
    await _service.scheduleNotification(
      kNotificationIdFertileWindow,
      _kFertileWindowTitle,
      bodyText,
      triggerTime,
    );
  }

  /// Schedules a recurring daily reminder at [time].
  ///
  /// Delegates to [NotificationService.scheduleDailyNotification] which uses
  /// DateTimeComponents.time so the notification fires every day at the same
  /// time without requiring a manual reschedule.
  Future<void> scheduleDailyReminder(TimeOfDay time) async {
    await _service.scheduleDailyNotification(
      kNotificationIdDailyReminder,
      _kDailyReminderTitle,
      _kDailyReminderBody,
      time,
    );
  }

  /// Cancels all Cara notifications then reschedules based on [prediction]
  /// and [prefs].
  ///
  /// - period_approaching: requires enabled pref + non-null prediction.
  /// - fertile_window: requires enabled pref + non-null prediction.
  /// - daily_reminder: requires enabled pref + valid HH:MM timeOfDay string.
  ///
  /// Prediction notifications are silently skipped when trigger dates are past.
  Future<void> rescheduleAll(
    CyclePredictionModel? prediction,
    List<NotificationPreferenceModel> prefs,
  ) async {
    await cancelAll();
    final prefMap = <String, NotificationPreferenceModel>{};
    for (final p in prefs) {
      prefMap[p.type] = p;
    }

    final periodPref = prefMap[kNotificationTypePeriodApproaching];
    if (periodPref != null && periodPref.enabled && prediction != null) {
      await schedulePeriodApproaching(prediction, periodPref);
    }

    final fertilePref = prefMap[kNotificationTypeFertileWindow];
    if (fertilePref != null && fertilePref.enabled && prediction != null) {
      await scheduleFertileWindow(prediction, fertilePref);
    }

    final dailyPref = prefMap[kNotificationTypeDailyReminder];
    if (dailyPref != null && dailyPref.enabled) {
      final timeOfDay = _parseTimeOfDay(dailyPref.timeOfDay);
      if (timeOfDay != null) {
        await scheduleDailyReminder(timeOfDay);
      }
    }
  }

  /// Cancels all Cara-managed notifications by their known IDs.
  Future<void> cancelAll() async {
    await Future.wait([
      _service.cancelNotification(kNotificationIdPeriodApproaching),
      _service.cancelNotification(kNotificationIdFertileWindow),
      _service.cancelNotification(kNotificationIdDailyReminder),
    ]);
  }

  // -------------------------------------------------------------------------
  // Private helpers
  // -------------------------------------------------------------------------

  /// Parses a HH:MM time string into a [TimeOfDay].
  /// Returns null for null or malformed input.
  TimeOfDay? _parseTimeOfDay(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final parts = raw.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }
}
