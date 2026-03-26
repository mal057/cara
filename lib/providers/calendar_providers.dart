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
    final CycleDao cycleDao;
    try {
      cycleDao = _ref.read(cycleDaoProvider);
    } catch (_) { return; }
    final MonthData monthData;
    try {
      monthData = await cycleDao.getMonthData(month);
    } catch (_) { return; }
    final currentCycle = _ref.read(currentCycleProvider).value;
    final prediction = _ref.read(predictionProvider).value;
    final dayMap = _buildDayMap(month, monthData, currentCycle, prediction);
    state = Map<String, Map<DateTime, DayDataModel>>.from(state)..[key] = dayMap;
  }

  Map<DateTime, DayDataModel> _buildDayMap(
    DateTime month, MonthData monthData,
    CycleModel? currentCycle, CyclePredictionModel? prediction) {
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
      if (currentCycle != null) {
        final dayInCycle = date.difference(currentCycle.startDate).inDays + 1;
        if (dayInCycle >= 1) {
          cycleDay = dayInCycle;
          final cycleLength = currentCycle.cycleLength ??
              (prediction != null
                  ? prediction.predictedStart.difference(currentCycle.startDate).inDays
                  : 28);
          final periodLength = currentCycle.periodLength ?? 5;
          phase = PhaseCalculator.calculatePhaseForDay(dayInCycle, periodLength, cycleLength);
        }
      }
      if (prediction != null &&
          !date.isBefore(prediction.predictedStart) &&
          !date.isAfter(prediction.predictedEnd)) {
        isPredicted = true;
        phase ??= CyclePhase.menstrual;
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
