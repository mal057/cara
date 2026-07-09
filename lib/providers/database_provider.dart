import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/database/daos/cycle_dao.dart';
import '../data/database/daos/daily_note_dao.dart';
import '../data/database/daos/notification_dao.dart';
import '../data/database/daos/period_log_dao.dart';
import '../data/database/daos/settings_dao.dart';
import '../data/database/daos/symptom_dao.dart';
import 'auth_providers.dart';

/// Provides the singleton [AppDatabase] instance.
///
/// The database is opened with the encryption key retrieved after a successful
/// authentication. [authStateProvider] must be in the authenticated state before
/// any DAO provider is read, as they all depend on this provider.
///
/// This is an [AsyncNotifier] because opening the SQLCipher database requires
/// async work (key retrieval + file I/O). Widgets that read DAO providers must
/// handle the [AsyncValue] loading and error states.
final databaseProvider =
    AsyncNotifierProvider<_DatabaseNotifier, AppDatabase>(_DatabaseNotifier.new);

class _DatabaseNotifier extends AsyncNotifier<AppDatabase> {
  @override
  Future<AppDatabase> build() async {
    // Listen (not watch) to auth state changes. Only retry opening the
    // database when we are currently in an error state and auth becomes
    // ready. This avoids unnecessary rebuilds (and duplicate DB instances)
    // when auth state changes after the database is already open.
    ref.listen(authStateProvider, (prev, next) {
      if (next.isAuthenticated && state is AsyncError) {
        ref.invalidateSelf();
      }
    });

    final authService = ref.read(authServiceProvider);
    if (!authService.isAuthenticated) {
      throw StateError(
        'User is not authenticated. Database will open after auth completes.',
      );
    }

    final encryptionKey = await authService.getEncryptionKey();
    if (encryptionKey == null) {
      throw StateError(
        'No encryption key found. Onboarding must be completed before '
        'opening the database.',
      );
    }
    final db = await AppDatabase.connect(encryptionKey);

    // Close the database when this provider is disposed (e.g. on sign-out /
    // data-delete flows where the container is refreshed).
    ref.onDispose(db.close);

    return db;
  }
}

/// Provides the [CycleDao] for cycle and month-data queries.
///
/// Reads synchronously from the resolved [databaseProvider]. Throws if the
/// database is not yet open — callers must guard with [AsyncValue].
final cycleDaoProvider = Provider<CycleDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return CycleDao(db);
});

/// Provides the [PeriodLogDao] for period log CRUD operations.
final periodLogDaoProvider = Provider<PeriodLogDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return PeriodLogDao(db);
});

/// Provides the [SymptomDao] for symptom reference data and entry operations.
final symptomDaoProvider = Provider<SymptomDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return SymptomDao(db);
});

/// Provides the [DailyNoteDao] for per-day note upserts.
final dailyNoteDaoProvider = Provider<DailyNoteDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return DailyNoteDao(db);
});

/// Provides the [SettingsDao] for key-value settings persistence.
final settingsDaoProvider = Provider<SettingsDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return SettingsDao(db);
});

/// Provides the [NotificationDao] for notification-preference persistence.
final notificationDaoProvider = Provider<NotificationDao>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return NotificationDao(db);
});
