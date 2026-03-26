import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/enums/export_format.dart';
import '../../core/enums/export_range.dart';
import '../../data/models/export_data_model.dart';
import 'csv_exporter.dart';
import 'pdf_exporter.dart';

/// Orchestrates data export to CSV and PDF formats.
///
/// Both [exportCsv] and [exportPdf] run the heavy generation work inside
/// [Isolate.run()] to keep the main thread responsive (Karla Note 5).
/// Files are written to the app documents directory and shared via the
/// OS share sheet using share_plus.
class ExportService {
  const ExportService({
    CsvExporter csvExporter = const CsvExporter(),
    PdfExporter pdfExporter = const PdfExporter(),
  })  : _csvExporter = csvExporter,
        _pdfExporter = pdfExporter;

  final CsvExporter _csvExporter;
  final PdfExporter _pdfExporter;

  // File name prefix used for exported files.
  static const _filePrefix = 'sola-export';
  static const _reportPrefix = 'sola-report';

  /// Exports data as a UTF-8 BOM CSV file.
  ///
  /// Generates the CSV content in [Isolate.run()], writes the result to
  /// the app documents directory, and returns the [File] handle.
  /// File name format: sola-export-YYYY-MM-DD.csv
  Future<File> exportCsv(ExportRange range, ExportDataModel data) async {
    // Run CSV generation in an isolate to avoid blocking the UI
    final csvContent = await Isolate.run(() => _csvExporter.generate(data));

    final file = await _buildOutputFile(ExportFormat.csv);
    await file.writeAsString(csvContent, encoding: const Utf8Codec());
    return file;
  }

  /// Exports data as an A4 PDF doctor-ready report.
  ///
  /// Generates the PDF bytes in [Isolate.run()] to avoid main-thread
  /// memory spikes on large datasets (Karla Note 5), writes the result to
  /// the app documents directory, and returns the [File] handle.
  /// File name format: sola-report-YYYY-MM-DD.pdf
  Future<File> exportPdf(ExportRange range, ExportDataModel data) async {
    // Run PDF generation in an isolate -- memory-intensive (Karla Note 5)
    final pdfBytes =
        await Isolate.run(() => _pdfExporter.generate(data));

    final file = await _buildOutputFile(ExportFormat.pdf);
    await file.writeAsBytes(pdfBytes);
    return file;
  }

  /// Opens the OS share sheet for [file].
  ///
  /// Uses share_plus [ShareXFiles] to trigger the native share sheet.
  /// No network calls are made -- the file stays on the device until
  /// the user explicitly shares it.
  Future<void> shareFile(File file) async {
    final xFile = XFile(
      file.path,
      mimeType: _mimeTypeForPath(file.path),
    );
    await SharePlus.instance.share(
      ShareParams(files: [xFile], subject: 'Sola Cycle Report'),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Builds the output [File] path in the app documents directory.
  /// File name: sola-export-YYYY-MM-DD.csv / sola-report-YYYY-MM-DD.pdf
  Future<File> _buildOutputFile(ExportFormat format) async {
    final dir = await getApplicationDocumentsDirectory();
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final dateStr = '$y-$m-$d';
    final prefix =
        format == ExportFormat.csv ? _filePrefix : _reportPrefix;
    final fileName = '$prefix-$dateStr.${format.fileExtension}';
    return File('${dir.path}/$fileName');
  }

  String _mimeTypeForPath(String path) {
    if (path.endsWith('.pdf')) return ExportFormat.pdf.mimeType;
    return ExportFormat.csv.mimeType;
  }
}
