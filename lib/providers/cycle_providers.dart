import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/cycle_model.dart';
import '../data/models/cycle_prediction_model.dart';
import '../data/models/cycle_stats_model.dart';
import '../services/cycle/cycle_detection_service.dart';
import '../services/cycle/cycle_prediction_service.dart';
import '../services/cycle/phase_calculator.dart';
import 'database_provider.dart';

// ---------------------------------------------------------------------------
// Services
// ---------------------------------------------------------------------------

/// Provides the singleton [CyclePredictionService].
///
/// The service is pure (no database access). Its [onRecalculate] callback is
/// left null here because rescheduling notifications in response to data
/// changes is coordinated at a higher level (notification_providers.dart).
/// Screens that modify cycle data should call [CyclePredictionService.recalculate]
/// after writes to trigger the 5-second debounced reschedule (Karla Note 6).
final cyclePredictionServiceProvider = Provider<CyclePredictionService>((ref) {
  final service = CyclePredictionService();
  ref.onDispose(service.dispose);
  return service;
});

/// Provides the singleton [CycleDetectionService].
///
/// Used by [LogScreen] (and any other screen that saves period logs) to
/// automatically reconcile cycle boundaries whenever a period log is
/// inserted or deleted. Call [CycleDetectionService.processLog] inside
/// the same database transaction that writes the period log.
final cycleDetectionServiceProvider = Provider<CycleDetectionService>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  final cycleDao = ref.watch(cycleDaoProvider);
  final periodLogDao = ref.watch(periodLogDaoProvider);
  return CycleDetectionService(
    cycleDao: cycleDao,
    periodLogDao: periodLogDao,
    db: db,
  );
});

// ---------------------------------------------------------------------------
// Reactive data
// ---------------------------------------------------------------------------

/// Watches the currently active cycle and emits on every change.
///
/// Uses [CycleDao.watchCurrentCycle] which applies `.distinct()` to suppress
/// duplicate emissions (Karla Note 7). Emits null when there is no open cycle.
final currentCycleProvider = StreamProvider<CycleModel?>((ref) {
  final cycleDao = ref.watch(cycleDaoProvider);
  return cycleDao.watchCurrentCycle();
});

/// Fetches the most recent completed cycles (up to 6 by default).
///
/// Used as the data source for [predictionProvider] and [cycleStatsProvider].
/// Re-fetched whenever the provider is invalidated (e.g. after a cycle is
/// closed or a new one is started).
final completedCyclesProvider = FutureProvider<List<CycleModel>>((ref) async {
  final cycleDao = ref.watch(cycleDaoProvider);
  return cycleDao.getCompletedCycles();
});

/// Computes a [CyclePredictionModel] from the most recent completed cycles.
///
/// When 3+ completed cycles exist, uses the weighted moving average algorithm.
/// Otherwise falls back to the current cycle's length settings (from
/// onboarding) to produce a simple prediction so the calendar shows expected
/// next-period days immediately.
final predictionProvider = FutureProvider<CyclePredictionModel?>((ref) async {
  final cycles = await ref.watch(completedCyclesProvider.future);
  final service = ref.read(cyclePredictionServiceProvider);
  final prediction = service.predictNextCycle(cycles);
  if (prediction != null) return prediction;

  // Fallback: use the current (ongoing) cycle's length settings to generate
  // a simple prediction. This covers the common case where the user has just
  // completed onboarding and expects the 28-day cycle they entered to drive
  // predicted period dates on the calendar right away.
  final currentCycle = await ref.watch(currentCycleProvider.future);
  if (currentCycle == null) return null;

  final cycleLength = currentCycle.cycleLength;
  final periodLength = currentCycle.periodLength ?? 5;
  if (cycleLength == null || cycleLength <= 14) return null;

  final predictedStart =
      currentCycle.startDate.add(Duration(days: cycleLength));
  final predictedEnd =
      predictedStart.add(Duration(days: periodLength - 1));

  final ovulationDay = PhaseCalculator.getOvulationDay(cycleLength);
  final fertileWindow = PhaseCalculator.getFertileWindow(ovulationDay);
  final fertileWindowStart =
      predictedStart.add(Duration(days: fertileWindow.$1 - 1));
  final fertileWindowEnd =
      predictedStart.add(Duration(days: fertileWindow.$2 - 1));

  return CyclePredictionModel(
    predictedStart: predictedStart,
    predictedEnd: predictedEnd,
    fertileWindowStart: fertileWindowStart,
    fertileWindowEnd: fertileWindowEnd,
    confidence: 0.3,
    isIrregular: false,
  );
});

/// Computes aggregate [CycleStatsModel] from the most recent completed cycles.
///
/// Returns null when no completed cycles exist.
final cycleStatsProvider = FutureProvider<CycleStatsModel?>((ref) async {
  final cycles = await ref.watch(completedCyclesProvider.future);
  final service = ref.read(cyclePredictionServiceProvider);
  return service.getStats(cycles);
});
