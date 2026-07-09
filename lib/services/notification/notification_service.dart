import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Top-level background tap handler: must be annotated so the Dart tree-shaker
// keeps it alive for background isolate invocation.
@pragma('vm:entry-point')
void _onDidReceiveBackgroundNotificationResponse(
  NotificationResponse response,
) {
  // Background isolate: no UI work. Log or queue for later if needed.
  // Deep-link routing is handled in the foreground callback only.
  debugPrint(
    'NotificationService: background tap id=${response.id} '
    'payload=${response.payload}',
  );
}

/// Payload value written into every scheduled notification.
/// Consumed by [NotificationService.initialize]'s foreground callback to
/// navigate the user to the Calendar tab.
const String _kCalendarPayload = 'calendar';

/// Channel identifiers for the Android notification channel.
const String kNotificationChannelId = 'cara_reminders';
const String kNotificationChannelName = 'Cara Reminders';

/// Callback signature for navigation triggered by a notification tap.
typedef NotificationTapCallback = void Function(String? payload);

/// Initializes and manages local notifications for the Cara app.
///
/// Responsibilities:
/// - Plugin initialization (Android channel + iOS settings + timezone data)
/// - Runtime permission requests (Android 13+ POST_NOTIFICATIONS, iOS)
/// - Scheduling and cancelling notifications
///
/// Actual scheduling logic for period predictions is handled by
/// [NotificationScheduler] (FLUTTER 3.4).
class NotificationService {
  NotificationService({NotificationTapCallback? onNotificationTap})
    : _onNotificationTap = onNotificationTap;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Called when the user taps a notification while the app is in the
  /// foreground or resumes from background. Passes the payload string so the
  /// app can route to the appropriate screen (e.g. Calendar tab).
  final NotificationTapCallback? _onNotificationTap;

  /// Whether [initialize] has completed successfully.
  bool _initialized = false;

  // -------------------------------------------------------------------------
  // Public API
  // -------------------------------------------------------------------------

  /// Initializes the plugin, creates the Android notification channel, and
  /// loads timezone data.
  ///
  /// Must be called once before any other method. Safe to call from
  /// [main] or a Riverpod provider initializer.
  Future<void> initialize() async {
    if (_initialized) return;

    // 1. Timezone data: must run before zonedSchedule is used.
    _initializeTimeZone();

    // 2. Android initialization settings.
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 3. iOS initialization settings.
    //    Defer the permission prompt to [requestPermission] so the app can
    //    ask at a natural moment (e.g. first time the user enables reminders).
    const IOSInitializationSettings iosSettings = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _handleForegroundTap,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );

    // 4. Create the Android notification channel (no-op on iOS).
    //    Called after initialize() so the method channel is ready.
    await _createAndroidChannel();

    _initialized = true;
  }

  /// Requests notification permissions at runtime.
  ///
  /// On Android 13+ (API 33) this triggers the POST_NOTIFICATIONS dialog.
  /// On iOS this triggers the standard UNUserNotificationCenter prompt.
  /// On older Android versions this is a no-op (permissions granted at
  /// install time via the manifest).
  ///
  /// Returns [true] if permission was granted, [false] if denied.
  Future<bool> requestPermission() async {
    _assertInitialized();

    if (!kIsWeb && Platform.isIOS) {
      final bool? granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }

    if (!kIsWeb && Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin == null) return false;

      // requestNotificationsPermission is meaningful on Android 13+.
      // On older versions the call is a no-op and returns true.
      final bool? granted =
          await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    return false;
  }

  /// Schedules a local notification to fire at [scheduledDate].
  ///
  /// [id] must be unique per notification. Use the ID constants defined in
  /// [NotificationScheduler] (1000 = period, 2000 = fertile, 3000 = daily).
  /// [title] and [body] are shown in the system notification shade.
  /// [scheduledDate] is a wall-clock time in the device local timezone.
  ///
  /// All Cara notifications embed [_kCalendarPayload] so tapping one always
  /// navigates the user to the Calendar tab.
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    _assertInitialized();

    // Convert plain DateTime to timezone-aware TZDateTime using tz.local.
    // tz.local is initialized in _initializeTimeZone(); TZDateTime.from
    // respects the system UTC offset to produce the correct epoch timestamp.
    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          kNotificationChannelId,
          kNotificationChannelName,
          channelDescription: 'Cara period and cycle reminders',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzScheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: _kCalendarPayload,
      );
    } on PlatformException catch (_) {
      // Exact alarms may not be permitted on Android 12+. Fall back to
      // inexact scheduling so the notification still fires (within a few
      // minutes of the target time).
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzScheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: _kCalendarPayload,
      );
    }
  }

  /// Cancels the scheduled or displayed notification with the given [id].
  Future<void> cancelNotification(int id) async {
    _assertInitialized();
    await _plugin.cancel(id: id);
  }

  /// Cancels all scheduled and displayed notifications created by this app.
  Future<void> cancelAllNotifications() async {
    _assertInitialized();
    await _plugin.cancelAll();
  }


  /// Schedules a recurring daily notification at the given [time].
  ///
  /// Uses [matchDateTimeComponents: DateTimeComponents.time] so the
  /// notification fires at the same hour and minute every day without
  /// requiring a manual reschedule.
  ///
  /// [id] must be the stable daily reminder ID (3000). [title] and [body]
  /// are shown in the system notification shade. [time] is in local time.
  Future<void> scheduleDailyNotification(
    int id,
    String title,
    String body,
    TimeOfDay time,
  ) async {
    _assertInitialized();

    final now = DateTime.now();
    // Compute the next occurrence of [time] today or tomorrow.
    var scheduled = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    if (scheduled.isBefore(now)) {
      // Time has already passed today; schedule for tomorrow.
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final tz.TZDateTime tzScheduled = tz.TZDateTime.from(scheduled, tz.local);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          kNotificationChannelId,
          kNotificationChannelName,
          channelDescription: 'Cara period and cycle reminders',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzScheduled,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: _kCalendarPayload,
    );
  }

  // -------------------------------------------------------------------------
  // Private helpers
  // -------------------------------------------------------------------------

  /// Loads all timezone definitions from the embedded latest_all dataset.
  ///
  /// No network access is required, preserving Cara's offline-only design.
  /// tz.local defaults to UTC; TZDateTime.from(localDateTime, tz.local)
  /// still produces the correct epoch timestamp because it uses the
  /// DateTime's built-in UTC offset.
  void _initializeTimeZone() {
    tz.initializeTimeZones();
  }

  /// Creates the Android notification channel for all Cara reminders.
  ///
  /// Idempotent: Android ignores duplicate createNotificationChannel calls
  /// for an existing channel ID (unless the channel was previously deleted).
  Future<void> _createAndroidChannel() async {
    if (kIsWeb || !Platform.isAndroid) return;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      kNotificationChannelId,
      kNotificationChannelName,
      description:
          'Reminders about your period, fertile window, and daily log.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  /// Handles a notification tap while the app is in the foreground or
  /// resumes from background.
  void _handleForegroundTap(NotificationResponse response) {
    _onNotificationTap?.call(response.payload);
  }

  /// Throws a [StateError] if [initialize] has not been called yet.
  void _assertInitialized() {
    if (!_initialized) {
      throw StateError(
        'NotificationService.initialize() must be called before '
        'using this service.',
      );
    }
  }
}

