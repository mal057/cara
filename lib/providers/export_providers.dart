import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../services/export/export_service.dart';

/// Represents the lifecycle of an export operation.
enum ExportStatus {
  /// No export is in progress.
  idle,

  /// An export is being generated (CSV/PDF in isolate).
  generating,

  /// The export completed successfully and the file is ready to share.
  complete,

  /// The export failed due to an error.
  error,
}

/// Provides the singleton [ExportService].
///
/// [ExportService] is stateless (const constructor). Both [exportCsv] and
/// [exportPdf] run heavy generation in [Isolate.run()] (Karla Note 5) so no
/// UI blocking occurs.
final exportServiceProvider = Provider<ExportService>((ref) {
  return const ExportService();
});

/// Tracks the current [ExportStatus] for the ExportScreen UI.
///
/// Screens update via [ref.read(exportStatusProvider.notifier).state] to drive
/// loading indicators and success/error messaging.
final exportStatusProvider = StateProvider<ExportStatus>((ref) {
  return ExportStatus.idle;
});
