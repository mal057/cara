import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/flow_color.dart';
import '../../core/enums/flow_intensity.dart';

part 'period_log_model.freezed.dart';
part 'period_log_model.g.dart';

/// App-level model for a single day's period log entry.
///
/// Maps from a [PeriodLogsTable] row. Uses type-safe [FlowIntensity] and
/// [FlowColor] enums rather than the raw strings stored in the database.
@freezed
abstract class PeriodLogModel with _$PeriodLogModel {
  const factory PeriodLogModel({
    /// Database row ID from period_logs table.
    required int id,

    /// The calendar date this log covers. One log per day.
    required DateTime date,

    /// Foreign key to the parent cycle. Null if not yet assigned to a cycle.
    int? cycleId,

    /// Flow intensity for this day.
    required FlowIntensity flowIntensity,

    /// Flow color for this day. Null if user did not specify.
    FlowColor? flowColor,

    /// When this row was first inserted.
    required DateTime createdAt,

    /// When this row was last updated.
    required DateTime updatedAt,
  }) = _PeriodLogModel;

  factory PeriodLogModel.fromJson(Map<String, dynamic> json) =>
      _$PeriodLogModelFromJson(json);
}
