import '../../core/enums/cycle_phase.dart';
import '../../core/enums/flow_intensity.dart';
import '../../data/models/day_data_model.dart';
import '../../data/models/export_data_model.dart';
import 'package:csv/csv.dart';

/// Generates a UTF-8 with BOM CSV document from [ExportDataModel].
///
/// Each row represents one calendar day in the export window.
/// Columns: Date, Period (Y/N), Flow Intensity, Flow Color,
/// Cycle Day, Phase, Symptoms, Severity, Notes.
/// Symptoms and severities are semicolon-separated within their cells.
///
/// Designed to run inside [Isolate.run()] — no Flutter/UI dependencies.
class CsvExporter {
  const CsvExporter();

  /// Converts [data] into a UTF-8 BOM-prefixed CSV string.
  ///
  /// Returns the complete CSV content ready to be written to a .csv file.
  /// The caller ([ExportService]) wraps this in [Isolate.run()].
  String generate(ExportDataModel data) {
    final rows = <List<dynamic>>[];

    // Header row — matches experience.md section 7.2 column spec
    rows.add([
      'Date',
      'Period',
      'Flow Intensity',
      'Flow Color',
      'Cycle Day',
      'Phase',
      'Symptoms',
      'Severity',
      'Notes',
    ]);

    // Sort daily data chronologically before emitting rows
    final sortedDays = [...data.dailyData]
      ..sort((a, b) => a.date.compareTo(b.date));

    for (final day in sortedDays) {
      rows.add(_buildRow(day));
    }

    final encoder = CsvEncoder(addBom: true);
    return encoder.convert(rows);

  }

  List<dynamic> _buildRow(DayDataModel day) {
    final log = day.periodLog;
    final hasPeriod = log != null;

    // ISO-8601 date string YYYY-MM-DD
    final dateStr =
        '${day.date.year.toString().padLeft(4, '0')}-'
        '${day.date.month.toString().padLeft(2, '0')}-'
        '${day.date.day.toString().padLeft(2, '0')}';

    final periodStr = hasPeriod ? 'Y' : 'N';

    final flowIntensityStr =
        hasPeriod ? _flowIntensityLabel(log.flowIntensity) : '';

    final flowColorStr =
        (hasPeriod && log.flowColor != null)
            ? _capitalize(log.flowColor!.name)
            : '';

    final cycleDayStr = day.cycleDay?.toString() ?? '';

    final phaseStr = day.phase != null ? _phaseLabel(day.phase!) : '';

    // Semicolon-separated symptom names
    final symptomsStr =
        day.symptomEntries.map((e) => e.symptom?.name ?? 'Unknown').join('; ');

    // Semicolon-separated severities aligned with symptom order
    final severityStr =
        day.symptomEntries.map((e) => e.severity.displayName).join('; ');

    final notesStr = day.dailyNote?.content ?? '';

    return [
      dateStr,
      periodStr,
      flowIntensityStr,
      flowColorStr,
      cycleDayStr,
      phaseStr,
      symptomsStr,
      severityStr,
      notesStr,
    ];
  }

  String _flowIntensityLabel(FlowIntensity intensity) {
    switch (intensity) {
      case FlowIntensity.light:
        return 'Light';
      case FlowIntensity.medium:
        return 'Medium';
      case FlowIntensity.heavy:
        return 'Heavy';
    }
  }

  String _phaseLabel(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'Menstrual';
      case CyclePhase.follicular:
        return 'Follicular';
      case CyclePhase.ovulatory:
        return 'Ovulatory';
      case CyclePhase.luteal:
        return 'Luteal';
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }
}
