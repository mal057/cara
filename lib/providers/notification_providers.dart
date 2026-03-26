import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/notification_preference_model.dart';
import '../services/notification/notification_scheduler.dart';
import '../services/notification/notification_service.dart';
import 'database_provider.dart';

// ---------------------------------------------------------------------------
// Service singletons
// ---------------------------------------------------------------------------

/// Provides the singleton [NotificationService].
///
/// [NotificationService.initialize] must be called once early in the app
/// lifecycle (e.g. in main() or an app-level provider listener) before any
/// other notification methods are invoked.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Provides the singleton [NotificationScheduler].
///
/// Depends on [notificationServiceProvider] so the scheduler always uses the
/// same plugin instance. Call [NotificationScheduler.rescheduleAll] whenever
/// cycle predictions or notification preferences change.
final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  final service = ref.read(notificationServiceProvider);
  return NotificationScheduler(notificationService: service);
});

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

/// Fetches the current notification preferences (3 rows: period, fertile,
/// daily) from the database.
///
/// Re-fetch by invalidating this provider after preference changes.
final notificationPrefsProvider =
    FutureProvider<List<NotificationPreferenceModel>>((ref) async {
  final dao = ref.watch(notificationDaoProvider);
  return dao.getPreferences();
});
