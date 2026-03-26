import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_log_model.dart';
import 'symptom_entry_model.dart';

part 'month_data_model.freezed.dart';

/// All logged data for a single calendar month.
///
/// Returned by [CycleDao.getMonthData]. Both lists are fetched in a single
/// database round-trip and cached by [monthDataCacheProvider] (per Karla Note 2).
/// UI widgets perform O(1) lookups into this structure rather than issuing
/// individual per-day queries.
@freezed
abstract class MonthData with _$MonthData {
  const factory MonthData({
    /// All period log entries for the month, ordered by date ascending.
    @Default([]) List<PeriodLogModel> periodLogs,

    /// All symptom entries for the month, ordered by date ascending.
    @Default([]) List<SymptomEntryModel> symptomEntries,
  }) = _MonthData;
}
