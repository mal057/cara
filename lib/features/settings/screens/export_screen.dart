import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/sola_scaffold.dart';
import '../widgets/export_section.dart';

/// Standalone export screen accessible via deep-link or from Settings.
///
/// Wraps [ExportSection] in a scrollable scaffold so the same export
/// controls are available both inline (Settings Data section) and as a
/// dedicated destination.
class ExportScreen extends ConsumerWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SolaScaffold(
      title: 'Export Data',
      child: SingleChildScrollView(
        child: ExportSection(),
      ),
    );
  }
}
