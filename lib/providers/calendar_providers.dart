import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../data/database/daos/cycle_dao.dart';
import '../data/models/cycle_model.dart';
import '../data/models/cycle_prediction_model.dart';
import '../data/models/day_data_model.dart';
import '../data/models/month_data_model.dart';
import '../data/models/period_log_model.dart';
import '../data/models/symptom_entry_model.dart';
import '../services/cycle/phase_calculator.dart';
import '../core/enums/cycle_phase.dart';
import 'cycle_providers.dart';
import 'database_provider.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final focusedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final monthDataCacheProvider = StateNotifierProvider<MonthDataCacheNotifier,
    Map<String, Map<DateTime, DayDataModel>>>((ref) {
  return MonthDataCacheNotifier(ref);
});

class MonthDataCacheNotifier
    extends StateNotifier<Map<String, Map<DateTime, DayDataModel>>> {
  MonthDataCacheNotifier(this._ref) : super({}) {
    // Rebuild all cached months when cycle or prediction data changes so
    // phase colours and prediction markers appear as soon as those async
    // providers resolve (fixes blank calendar after onboarding).
    _ref.listen<AsyncValue<CycleModel?>>(currentCycleProvider, (prev, next) {
      if (prev?.value != next.value) _rebuildAllCachedMonths();
    });
    _ref.listen<AsyncValue<CyclePredictionModel?>>(predictionProvider, (prev, next) {
      if (prev?.value != next.value) _rebuildAllCachedMonths();
    });

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _loadMonthIfMissing(today);
    _loadMonthIfMissing(DateTime(today.year, today.month - 1));
    _loadMonthIfMissing(DateTime(today.year, today.month + 1));
  }

  final Ref _ref;
  Future<void> loadMonth(DateTime focusedMonth) async {
    final prev = DateTime(focusedMonth.year, focusedMonth.month - 1);
    final next = DateTime(focusedMonth.year, focusedMonth.month + 1);
    final keysToKeep = {_monthKey(prev), _monthKey(focusedMonth), _monthKey(next)};
    if (state.keys.any((k) => !keysToKeep.contains(k))) {
      final pruned = Map<String, Map<DateTime, DayDataModel>>.from(state)
        ..removeWhere((k, _) => !keysToKeep.contains(k));
      state = pruned;
    }
    await Future.wait([
      _loadMonthIfMissing(prev),
      _loadMonthIfMissing(focusedMonth),
      _loadMonthIfMissing(next),
    ]);
  }

  void invalidateMonth(DateTime month) {
    final key = _monthKey(month);
    if (state.containsKey(key)) {
      state = Map<String, Map<DateTime, DayDataModel>>.from(state)..remove(key);
    }
  }

  Future<void> _loadMonthIfMissing(DateTime month) async {
    final key = _monthKey(month);
    if (state.containsKey(key)) return;
    await _reloadMonth(month);
  }

  /// Reloads a single month from the database and rebuilds its day map with
  /// the latest cycle / prediction data. Always overwrites the cached entry.
  Future<void> _reloadMonth(DateTime month) async {
    final CycleDao cycleDao;
    try {
      cycleDao = _ref.read(cycleDaoProvider);
    } catch (_) { return; }

    final results = await Future.wait([
      cycleDao.getMonthData(month),
      cycleDao.getAllCyclesSorted(),
    ]);

    final monthData = results[0] as MonthData;
    final allCycles = results[1] as List<CycleModel>;
    final prediction = _ref.read(predictionProvider).value;

    final dayMap = _buildDayMap(month, monthData, allCycles, prediction);
    state = Map<String, Map<DateTime, DayDataModel>>.from(state)
      ..[_monthKey(month)] = dayMap;
  }

  /// Rebuilds every currently-cached month with fresh cycle / prediction data.
  void _rebuildAllCachedMonths() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final prev = DateTime(today.year, today.month - 1);
    final next = DateTime(today.year, today.month + 1);

    final keysToReload = <String>{
      ...state.keys,
      _monthKey(prev),
      _monthKey(today),
      _monthKey(next),
    };

    for (final monthKey in keysToReload) {
      final parts = monthKey.split('-');
      _reloadMonth(DateTime(int.parse(parts[0]), int.parse(parts[1])));
    }
  }

  Map<DateTime, DayDataModel> _buildDayMap(
    DateTime month, MonthData monthData,
    List<CycleModel> allCycles, CyclePredictionModel? prediction) {
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    final logsByDate = <String, PeriodLogModel>{};
    for (final log in monthData.periodLogs) {
      logsByDate[_dateKey(log.date)] = log;
    }
    final entriesByDate = <String, List<SymptomEntryModel>>{};
    for (final entry in monthData.symptomEntries) {
      entriesByDate.putIfAbsent(_dateKey(entry.date), () => []).add(entry);
    }
    final result = <DateTime, DayDataModel>{};
    for (var day = 1; day <= lastDay; day++) {
      final date = DateTime(month.year, month.month, day);
      final periodLog = logsByDate[_dateKey(date)];
      final symptoms = entriesByDate[_dateKey(date)] ?? [];
      CyclePhase? phase;
      var isPredicted = false;
      int? cycleDay;

      // Try each cycle (sorted oldest-first) to find which one this day belongs to
      for (final cycle in allCycles) {
        final dayInCycle = date.difference(cycle.startDate).inDays + 1;
        if (dayInCycle < 1) continue; // Date is before this cycle started

        // Determine this cycle's length
        final cycleLength = cycle.cycleLength ??
            (cycle.endDate != null
                ? cycle.endDate!.difference(cycle.startDate).inDays + 1
                : (prediction != null
                    ? prediction.predictedStart.difference(cycle.startDate).inDays
                    : 28));
        final periodLength = cycle.periodLength ?? 5;

        if (dayInCycle >= 1 && dayInCycle <= cycleLength) {
          cycleDay = dayInCycle;
          phase = PhaseCalculator.calculatePhaseForDay(dayInCycle, periodLength, cycleLength);
          break; // Found the matching cycle
        }
      }

      // Project the cycle pattern forward for dates beyond all known cycles.
      // Uses the last cycle with a known cycleLength as the reference pattern.
      // Marked as predicted since these are projected, not confirmed.
      // Only projects AFTER the last known cycle's range — past dates with no
      // data remain blank so the user sees them as unlogged.
      if (phase == null && allCycles.isNotEmpty) {
        // Find the best reference cycle (prefer one with known cycleLength)
        CycleModel? refCycle;
        for (int i = allCycles.length - 1; i >= 0; i--) {
          if (allCycles[i].cycleLength != null) {
            refCycle = allCycles[i];
            break;
          }
        }
        refCycle ??= allCycles.last;

        final refCycleLength = refCycle.cycleLength ?? 28;
        final refPeriodLength = refCycle.periodLength ?? 5;
        final daysSinceStart = date.difference(refCycle.startDate).inDays;

        // Find the end of the last known cycle's confirmed range
        final lastCycle = allCycles.last;
        final lastCycleLength = lastCycle.cycleLength ??
            (lastCycle.endDate != null
                ? lastCycle.endDate!.difference(lastCycle.startDate).inDays + 1
                : lastCycle.periodLength ?? 5);
        final lastCycleEnd = lastCycle.startDate.add(Duration(
          days: lastCycleLength - 1,
        ));

        // Only project for dates after the last known cycle's range
        if (daysSinceStart >= 0 && refCycleLength > 0 && !date.isBefore(lastCycleEnd)) {
          final dayInProjectedCycle = (daysSinceStart % refCycleLength) + 1;
          cycleDay = dayInProjectedCycle;
          phase = PhaseCalculator.calculatePhaseForDay(
            dayInProjectedCycle, refPeriodLength, refCycleLength,
          );
          isPredicted = true;
        }
      }

      // Prediction overlay (predicted next period)
      if (prediction != null &&
          !date.isBefore(prediction.predictedStart) &&
          !date.isAfter(prediction.predictedEnd)) {
        isPredicted = true;
        phase = CyclePhase.menstrual;
      }

      result[date] = DayDataModel(
        date: date, periodLog: periodLog, symptomEntries: symptoms,
        phase: phase, isPredicted: isPredicted, cycleDay: cycleDay,
      );
    }
    return result;
  }

  static String _monthKey(DateTime dt) {
    final m = dt.month.toString().padLeft(2, '0');
    return "${dt.year}-$m";
  }

  static String _dateKey(DateTime dt) {
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return "${dt.year}-$m-$d";
  }
}

final dayDataProvider = Provider.family<DayDataModel?, DateTime>((ref, date) {
  final cache = ref.watch(monthDataCacheProvider);
  final m = date.month.toString().padLeft(2, '0');
  final monthKey = "${date.year}-$m";
  final monthMap = cache[monthKey];
  if (monthMap == null) return null;
  final normalised = DateTime(date.year, date.month, date.day);
  return monthMap[normalised];
});
