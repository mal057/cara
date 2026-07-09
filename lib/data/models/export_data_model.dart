import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enums/export_range.dart';
import 'cycle_model.dart';
import 'cycle_stats_model.dart';
import 'day_data_model.dart';

part 'export_data_model.freezed.dart';
part 'export_data_model.g.dart';

/// App-level model bundling all data required for CSV or PDF export.
///
/// Assembled by [ExportService] before handing off to [CsvExporter] or
/// [PdfExporter]. Both exporters run inside [Isolate.run()] so this model
/// must be fully self-contained (no database handles, no Dart UI objects).
@freezed
abstract class ExportDataModel with _$ExportDataModel {
  const factory ExportDataModel({
    /// The date-range selection that triggered this export.
    required ExportRange range,

    /// Inclusive start of the exported date window.
    /// Null when [range] is [ExportRange.allTime] and there are no cycles.
    DateTime? startDate,

    /// Inclusive end of the exported date window (typically today).
    required DateTime endDate,

    /// All completed (and current) cycles within the export window.
    @Default([]) List<CycleModel> cycles,

    /// Day-level aggregated data for every calendar day in the window.
    /// Used by the CSV exporter for the row-per-day format.
    @Default([]) List<DayDataModel> dailyData,

    /// Aggregate statistics for the export window.
    /// Null if there are fewer than 1 completed cycle.
    CycleStatsModel? stats,
  }) = _ExportDataModel;

  factory ExportDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExportDataModelFromJson(json);
}
