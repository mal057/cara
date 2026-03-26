import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/symptom_definitions.dart';
import '../../../core/enums/flow_color.dart';
import '../../../core/enums/flow_intensity.dart';
import '../../../core/enums/symptom_severity.dart';
import '../../../data/database/app_database.dart';
import '../../../data/models/daily_note_model.dart';
import '../../../data/models/period_log_model.dart';
import '../../../data/models/symptom_entry_model.dart';
import '../../../providers/calendar_providers.dart';
import '../../../providers/cycle_providers.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/symptom_providers.dart';
import '../../shared/widgets/sola_button.dart';
import '../../shared/widgets/sola_scaffold.dart';
import '../widgets/notes_input.dart';
import '../widgets/period_toggle.dart';
import '../widgets/symptom_grid.dart';

/// Quick-log screen for recording period status, symptoms, and a daily note.
///
/// Reads [selectedDateProvider] to know which date is being edited - this is
/// set by the calendar when the user taps a day, or defaults to today.
/// On first build it loads any existing data for the date so the user can
/// edit a previously-saved entry seamlessly.
///
/// Save writes all changes (period log, symptom entries, note) inside a single
/// database transaction (per Karla Note 1 - one SQLCipher flush for the batch).
/// After a successful save the [monthDataCacheProvider] is invalidated for the
/// edited month so the calendar refreshes immediately.
class LogScreen extends ConsumerStatefulWidget {
  const LogScreen({super.key});

  @override
  ConsumerState<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends ConsumerState<LogScreen> {
  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  late DateTime _editingDate;

  bool _isPeriodDay = false;
  FlowIntensity _intensity = FlowIntensity.medium;
  FlowColor? _flowColor;

  SymptomSelections _symptomSelections = {};

  late final TextEditingController _notesController;

  bool _isLoading = true;
  bool _isSaving = false;
  String? _saveError;

  int? _existingPeriodLogId;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadExistingData());
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Data loading
  // ---------------------------------------------------------------------------

  Future<void> _loadExistingData() async {
    final date = ref.read(selectedDateProvider);
    if (!mounted) return;
    setState(() {
      _editingDate = date;
      _isLoading = true;
      _saveError = null;
    });

    try {
      final periodLogDao = ref.read(periodLogDaoProvider);
      final symptomDao = ref.read(symptomDaoProvider);
      final dailyNoteDao = ref.read(dailyNoteDaoProvider);

      final results = await Future.wait([
        periodLogDao.getLogsForDateRange(date, date),
        symptomDao.getEntriesForDate(date),
        dailyNoteDao.getNoteForDate(date),
      ]);

      final periodLogs = results[0] as List<PeriodLogModel>;
      final symptomEntries = results[1] as List<SymptomEntryModel>;
      final note = results[2] as DailyNoteModel?;

      if (!mounted) return;

      bool isPeriodDay = false;
      int? existingPeriodLogId;
      FlowIntensity intensity = FlowIntensity.medium;
      FlowColor? flowColor;

      if (periodLogs.isNotEmpty) {
        final log = periodLogs.first;
        existingPeriodLogId = log.id;
        isPeriodDay = true;
        intensity = log.flowIntensity;
        flowColor = log.flowColor;
      }

      final selectionMap = <String, SymptomSeverity?>{};
      for (final entry in symptomEntries) {
        final symptomName = entry.symptom?.name ?? '';
        if (symptomName.isEmpty) continue;
        try {
          final def = kSymptomDefinitions.firstWhere(
            (d) => d.name.toLowerCase() == symptomName.toLowerCase(),
          );
          selectionMap[def.id] = entry.severity;
        } catch (_) {
          // Symptom in DB not in canonical list; skip.
        }
      }

      setState(() {
        _editingDate = date;
        _isPeriodDay = isPeriodDay;
        _existingPeriodLogId = existingPeriodLogId;
        _intensity = intensity;
        _flowColor = flowColor;
        _symptomSelections = selectionMap;
        _notesController.text = note?.content ?? '';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _saveError = 'Failed to load data. Please try again.';
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Save
  // ---------------------------------------------------------------------------

  Future<void> _save() async {
    if (_isSaving) return;
    setState(() {
      _isSaving = true;
      _saveError = null;
    });

    try {
      final db = ref.read(databaseProvider).requireValue;
      final periodLogDao = ref.read(periodLogDaoProvider);
      final symptomDao = ref.read(symptomDaoProvider);
      final dailyNoteDao = ref.read(dailyNoteDaoProvider);
      final cycleDetectionService =
          ref.read(cycleDetectionServiceProvider);

      final dateStr = _editingDate.toIso8601String().substring(0, 10);
      final now = DateTime.now().toIso8601String();

      int? savedPeriodLogId = _existingPeriodLogId;

      await db.transaction(() async {
        // -- Period log ---------------------------------------------------
        if (_isPeriodDay) {
          if (savedPeriodLogId != null) {
            await periodLogDao.updateLog(
              savedPeriodLogId!,
              PeriodLogsTableCompanion(
                date: Value(dateStr),
                flowIntensity: Value(_intensity.name),
                flowColor: Value(_flowColor?.name),
                updatedAt: Value(now),
              ),
            );
          } else {
            savedPeriodLogId = await periodLogDao.insertLog(
              PeriodLogsTableCompanion(
                date: Value(dateStr),
                flowIntensity: Value(_intensity.name),
                flowColor: Value(_flowColor?.name),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
          }
        } else if (savedPeriodLogId != null) {
          await periodLogDao.deleteLog(savedPeriodLogId!);
          savedPeriodLogId = null;
        }

        // -- Cycle detection (inside the transaction) -------------------
        await cycleDetectionService.processLog(_editingDate, _isPeriodDay);

        // -- Symptom entries (replace strategy) ---------------------------
        await symptomDao.deleteEntriesForDate(_editingDate);

        final symptoms = await symptomDao.getAllSymptoms();
        final selectedEntries = <SymptomEntriesTableCompanion>[];

        for (final def in kSymptomDefinitions) {
          final severity = _symptomSelections[def.id];
          if (severity == null) continue;
          try {
            final symptomModel = symptoms.firstWhere(
              (s) => s.name.toLowerCase() == def.name.toLowerCase(),
            );
            selectedEntries.add(SymptomEntriesTableCompanion(
              date: Value(dateStr),
              symptomId: Value(symptomModel.id),
              severity: Value(severity.value),
              createdAt: Value(now),
            ));
          } catch (_) {
            // Symptom definition not seeded; skip gracefully.
          }
        }

        if (selectedEntries.isNotEmpty) {
          await symptomDao.insertEntries(selectedEntries);
        }

        // -- Daily note ---------------------------------------------------
        final noteText = _notesController.text.trim();
        if (noteText.isNotEmpty) {
          await dailyNoteDao.upsertNote(DailyNotesTableCompanion(
            date: Value(dateStr),
            content: Value(noteText),
            createdAt: Value(now),
            updatedAt: Value(now),
          ));
        }
      });

      setState(() => _existingPeriodLogId = savedPeriodLogId);

      ref.read(monthDataCacheProvider.notifier).invalidateMonth(_editingDate);
      ref.invalidate(daySymptomEntriesProvider(_editingDate));

      // -- Prediction recalculation + notification rescheduling ---------
      // Invalidate completedCyclesProvider so the next read pulls the newly
      // saved period log from the database.  Then kick the 5-second
      // debounced recalculate which (via onRecalculate in
      // cyclePredictionServiceProvider) will refresh the prediction and
      // call NotificationScheduler.rescheduleAll automatically.
      ref.invalidate(completedCyclesProvider);
      await ref.read(cyclePredictionServiceProvider).recalculate();

      HapticFeedback.heavyImpact();

      if (!mounted) return;
      setState(() => _isSaving = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Saved!',
            style: AppTypography.body2.copyWith(color: AppColors.surface),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _saveError = 'Could not save. Please try again.';
      });
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);

    if (!_isLoading && selectedDate != _editingDate) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _loadExistingData());
    }

    return SolaScaffold(
      title: _formatDate(selectedDate),
      resizeToAvoidBottomInset: true,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSizes.space16,
        bottom: AppSizes.space40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            child: PeriodToggle(
              isPeriodDay: _isPeriodDay,
              onToggle: (v) => setState(() => _isPeriodDay = v),
              selectedIntensity: _intensity,
              onIntensityChanged: (v) => setState(() => _intensity = v),
              selectedColor: _flowColor,
              onColorChanged: (v) => setState(() => _flowColor = v),
            ),
          ),
          const SizedBox(height: AppSizes.sectionGap),
          const _SectionHeader(label: 'Symptoms'),
          const SizedBox(height: AppSizes.space12),
          _SectionCard(
            child: SymptomGrid(
              selections: _symptomSelections,
              onChanged: (updated) =>
                  setState(() => _symptomSelections = updated),
            ),
          ),
          const SizedBox(height: AppSizes.sectionGap),
          const _SectionHeader(label: 'Notes'),
          const SizedBox(height: AppSizes.space12),
          NotesInput(controller: _notesController),
          if (_saveError != null) ...[
            const SizedBox(height: AppSizes.space12),
            Text(
              _saveError!,
              style: AppTypography.caption.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppSizes.space24),
          SolaButton(
            label: 'Save',
            icon: Icons.check,
            isFullWidth: true,
            isLoading: _isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == -1) return 'Yesterday';
    if (diff == 1) return 'Tomorrow';
    return DateFormat('EEEE, d MMM').format(date);
  }
}

// ---------------------------------------------------------------------------
// Private layout helpers
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTypography.heading3);
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      child: child,
    );
  }
}
