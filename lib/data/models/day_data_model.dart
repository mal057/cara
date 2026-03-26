import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/cycle_phase.dart';
import 'daily_note_model.dart';
import 'period_log_model.dart';
import 'symptom_entry_model.dart';

part 'day_data_model.freezed.dart';
part 'day_data_model.g.dart';

/// App-level model aggregating all data for a single calendar day.
///
/// Combines period log, symptom entries, daily note, phase, and cycle day
/// into a single O(1)-lookup value used by [CalendarBuilders] via
/// [monthDataCacheProvider]. Created by the calendar provider layer,
/// NOT persisted directly.
@freezed
abstract class DayDataModel with _$DayDataModel {
  const factory DayDataModel({
    /// The calendar date this record covers.
    required DateTime date,

    /// Period log for this day. Null if the user did not log a period.
    PeriodLogModel? periodLog,

    /// All symptom entries logged for this day. Empty if none.
    @Default([]) List<SymptomEntryModel> symptomEntries,

    /// Free-form daily note for this day. Null if none was written.
    DailyNoteModel? dailyNote,

    /// Computed cycle phase for this day. Null if no active cycle data.
    CyclePhase? phase,

    /// Whether this day is within a predicted (not confirmed) period range.
    @Default(false) bool isPredicted,

    /// Day number within the current cycle (1-based). Null if no cycle data.
    int? cycleDay,
  }) = _DayDataModel;

  factory DayDataModel.fromJson(Map<String, dynamic> json) =>
      _$DayDataModelFromJson(json);
}
