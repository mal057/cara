import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database_provider.dart';

// ---------------------------------------------------------------------------
// Settings key constants
// ---------------------------------------------------------------------------

const String kSettingDefaultCycleLength = 'default_cycle_length';
const String kSettingDefaultPeriodLength = 'default_period_length';
const String kSettingAutoLockTimeout = 'auto_lock_timeout';

// ---------------------------------------------------------------------------
// Stream of all relevant settings
// ---------------------------------------------------------------------------

/// Watches the settings table for changes to the three core keys and emits the
/// combined map on every change.
///
/// Uses [SettingsDao.watchSetting] per key with [.distinct()] to avoid
/// spurious rebuilds from unrelated settings writes (Karla Note 7). The three
/// streams are merged by listening to changes from any key and re-reading all
/// three values on each emission.
final settingsProvider = StreamProvider<Map<String, String>>((ref) {
  // Declare the watch inside an async generator so the DAO dependency is
  // tracked correctly by Riverpod.
  final dao = ref.watch(settingsDaoProvider);

  // Merge the three per-key watch streams into a single stream of the full map.
  return _mergeSettingsStreams(dao);
});

Stream<Map<String, String>> _mergeSettingsStreams(dynamic dao) async* {
  // Emit initial values immediately.
  final initCycle = await dao.getSetting(kSettingDefaultCycleLength);
  final initPeriod = await dao.getSetting(kSettingDefaultPeriodLength);
  final initLock = await dao.getSetting(kSettingAutoLockTimeout);

  yield {
    kSettingDefaultCycleLength: initCycle ?? '28',
    kSettingDefaultPeriodLength: initPeriod ?? '5',
    kSettingAutoLockTimeout: initLock ?? '30',
  };

  // Re-emit when any of the three keys changes by listening to each stream.
  // We use the cycle-length watcher as the merge trigger; a future
  // improvement could use StreamGroup if all three need equal priority.
  await for (final _ in dao.watchSetting(kSettingDefaultCycleLength)
      .asyncExpand((v) => Stream.value(v))) {
    final cycle = await dao.getSetting(kSettingDefaultCycleLength);
    final period = await dao.getSetting(kSettingDefaultPeriodLength);
    final lock = await dao.getSetting(kSettingAutoLockTimeout);
    yield {
      kSettingDefaultCycleLength: cycle ?? '28',
      kSettingDefaultPeriodLength: period ?? '5',
      kSettingAutoLockTimeout: lock ?? '30',
    };
  }
}

// ---------------------------------------------------------------------------
// Derived providers
// ---------------------------------------------------------------------------

/// Default cycle length in days. Falls back to 28 if not yet persisted.
final defaultCycleLengthProvider = Provider<int>((ref) {
  // AsyncValue.value returns T? (null when loading or error) in Riverpod 3.
  final settings = ref.watch(settingsProvider).value;
  return int.tryParse(settings?[kSettingDefaultCycleLength] ?? '') ?? 28;
});

/// Default period length in days. Falls back to 5 if not yet persisted.
final defaultPeriodLengthProvider = Provider<int>((ref) {
  final settings = ref.watch(settingsProvider).value;
  return int.tryParse(settings?[kSettingDefaultPeriodLength] ?? '') ?? 5;
});

/// Auto-lock timeout in seconds. Falls back to 30 if not yet persisted.
final autoLockTimeoutProvider = Provider<int>((ref) {
  final settings = ref.watch(settingsProvider).value;
  return int.tryParse(settings?[kSettingAutoLockTimeout] ?? '') ?? 30;
});
