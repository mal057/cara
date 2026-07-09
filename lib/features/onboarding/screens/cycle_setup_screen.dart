import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/enums/flow_intensity.dart';
import '../../../data/database/daos/cycle_dao.dart';
import '../../../data/database/app_database.dart';
import '../../../data/database/tables/cycles_table.dart';
import '../../../navigation/route_names.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/calendar_providers.dart';
import '../../../providers/cycle_providers.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/settings_providers.dart';
import '../../shared/widgets/cara_button.dart';
import '../../shared/widgets/ocean_background/ocean_background.dart';
import '../widgets/cycle_length_slider.dart';
import '../widgets/confetti_widget.dart';

/// Cycle setup step within the onboarding wizard (all fields optional).
///
/// Collects three pieces of information:
///   1. Last period start date (date picker, defaults to today).
///   2. Period length in days (slider, 2-10 days, default 5).
///   3. Cycle length in days (slider, 21-45 days, default 28).
///
/// On Save, inserts an initial [CyclesTable] row via [CycleDao.insertCycle]
/// and persists cycle/period lengths to settings via [SettingsDao.setSetting].
/// On Skip, proceeds directly to the calendar without saving any data.
///
/// After saving (or skipping), calls [AuthStateNotifier.completeOnboarding]
/// so the GoRouter auth guard allows navigation to [RouteNames.calendar].
class CycleSetupScreen extends ConsumerStatefulWidget {
  const CycleSetupScreen({super.key});

  @override
  ConsumerState<CycleSetupScreen> createState() => _CycleSetupScreenState();
}

class _CycleSetupScreenState extends ConsumerState<CycleSetupScreen> {
  DateTime _lastPeriodDate = DateTime.now();
  int _periodLength = 5;
  int _cycleLength = 28;
  bool _isLoading = false;
  String? _errorMessage;
  final _confettiKey = GlobalKey<ConfettiWidgetState>();

  static const int _minPeriodLength = 2;
  static const int _maxPeriodLength = 10;
  static const int _minCycleLength = 21;
  static const int _maxCycleLength = 45;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodDate,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
      helpText: 'When did your last period start?',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                  onPrimary: AppColors.surface,
                  surface: AppColors.surface,
                  onSurface: AppColors.textPrimary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _lastPeriodDate = picked;
      });
    }
  }

  Future<void> _onSave() async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      final db = ref.read(databaseProvider).requireValue;
      final cycleDao = ref.read(cycleDaoProvider);
      final periodLogDao = ref.read(periodLogDaoProvider);
      final settingsDao = ref.read(settingsDaoProvider);

      final now = DateTime.now().toUtc().toIso8601String();
      final startDate = DateTime(
        _lastPeriodDate.year, _lastPeriodDate.month, _lastPeriodDate.day,
      ).toIso8601String().substring(0, 10);

      await db.transaction(() async {
        final cycleId = await cycleDao.insertCycle(
          CyclesTableCompanion.insert(
            startDate: startDate,
            periodLength: Value(_periodLength),
            cycleLength: Value(_cycleLength),
            createdAt: now, updatedAt: now,
          ),
        );

        for (int i = 0; i < _periodLength; i++) {
          final logDay = DateTime(
            _lastPeriodDate.year, _lastPeriodDate.month, _lastPeriodDate.day + i,
          );
          await periodLogDao.insertLog(PeriodLogsTableCompanion(
            date: Value(logDay.toIso8601String().substring(0, 10)),
            flowIntensity: Value(FlowIntensity.medium.name),
            cycleId: Value(cycleId),
            createdAt: Value(now), updatedAt: Value(now),
          ));
        }

        await settingsDao.setSetting(kSettingDefaultCycleLength, _cycleLength.toString());
        await settingsDao.setSetting(kSettingDefaultPeriodLength, _periodLength.toString());
      });

      // Post-save: invalidate cache so calendar reloads from DB
      final cacheNotifier = ref.read(monthDataCacheProvider.notifier);
      cacheNotifier.invalidateMonth(_lastPeriodDate);
      final lastDay = _lastPeriodDate.add(Duration(days: _periodLength - 1));
      if (lastDay.month != _lastPeriodDate.month) {
        cacheNotifier.invalidateMonth(lastDay);
      }
      ref.invalidate(completedCyclesProvider);
      // Pre-load the period month(s) so the calendar has data immediately.
      await cacheNotifier.loadMonth(_lastPeriodDate);

      if (!mounted) return;
      _completeOnboarding();
    } catch (e, st) {
      debugPrint('CycleSetupScreen._onSave failed: $e\n$st');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not save your cycle data. You can set this up later in Settings.';
      });
    }
  }

  void _onSkip() => _completeOnboarding();  // ignore: discarded_futures

  Future<void> _completeOnboarding() async {
    _confettiKey.currentState?.play();
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    // Wait for the Drift stream to resolve so PhaseBadge has data on mount.
    // The transaction committed before this method was called, so the stream
    // should already have the cycle row — this await is a safety net.
    try {
      await ref.read(currentCycleProvider.future).timeout(
        const Duration(seconds: 2),
      );
    } catch (_) {
      // Timeout or error — proceed anyway; PhaseBadge will show loading briefly.
    }
    if (!mounted) return;
    // Set auth state and navigate together — GoRouter redirect and context.go
    // both point to calendar, which is fine.
    ref.read(authStateProvider.notifier).completeOnboarding();
    context.go(RouteNames.calendar);
  }
  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('MMMM d, yyyy').format(_lastPeriodDate);

    return OceanBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textPrimary,
            tooltip: 'Back',
            onPressed: _isLoading ? null : () => context.go(RouteNames.biometricSetup),
          ),
        ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.space24),
              Text(
                'Set up your cycle',
                style: AppTypography.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.space8),
              Text(
                'This helps Cara give you more accurate predictions. All fields are optional.',
                style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.space32),
              _SectionLabel(label: 'When did your last period start?'),
              const SizedBox(height: AppSizes.space12),
              InkWell(
                onTap: _isLoading ? null : _pickDate,
                borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.space16,
                    vertical: AppSizes.space16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                    border: Border.all(color: AppColors.inputBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: AppSizes.iconMedium,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSizes.space12),
                      Text(
                        dateLabel,
                        style: AppTypography.body1.copyWith(color: AppColors.textPrimary),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: AppSizes.iconMedium,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.space32),
              CycleLengthSlider(
                label: 'Period length',
                value: _periodLength,
                min: _minPeriodLength,
                max: _maxPeriodLength,
                onChanged: (v) => setState(() => _periodLength = v),
              ),
              const SizedBox(height: AppSizes.space32),
              CycleLengthSlider(
                label: 'Cycle length',
                value: _cycleLength,
                min: _minCycleLength,
                max: _maxCycleLength,
                onChanged: (v) => setState(() => _cycleLength = v),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: AppSizes.space16),
                Container(
                  padding: const EdgeInsets.all(AppSizes.space12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withAlpha(15),
                    borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                    border: Border.all(color: AppColors.error.withAlpha(60)),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: AppTypography.caption.copyWith(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: AppSizes.space40),
              CaraButton(
                label: 'Save and Continue',
                onPressed: _isLoading ? null : _onSave,
                isFullWidth: true,
                isLoading: _isLoading,
              ),
              const SizedBox(height: AppSizes.space12),
              Center(
                child: TextButton(
                  onPressed: _isLoading ? null : _onSkip,
                  child: Text(
                    'Skip for now',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textPrimary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.space32),
            ],
          ),
        ),
          ),
          // Confetti overlay: renders on top of all content, ignores pointer events.
          ConfettiWidget(key: _confettiKey),
        ],
      ),
    ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.body1.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

