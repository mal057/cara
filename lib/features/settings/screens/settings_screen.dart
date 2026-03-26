import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../data/database/app_database.dart';
import 'package:go_router/go_router.dart';

import '../../../navigation/route_names.dart';
import '../../../providers/auth_providers.dart';
import '../../../services/auth/auth_service.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/notification_providers.dart';
import '../../../providers/settings_providers.dart';
import '../../shared/widgets/sola_scaffold.dart';
import '../widgets/delete_data_dialog.dart';
import '../widgets/export_section.dart';
import '../widgets/pin_change_dialog.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

/// Settings tab screen.
///
/// Five sections:
///   1. Cycle – default cycle/period length sliders.
///   2. Notifications – toggles + daily reminder time picker.
///   3. Security – change PIN, biometric toggle, auto-lock timeout.
///   4. Data – inline export widget + delete all data.
///   5. About – version, privacy policy, device-local data badge.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final notifsAsync = ref.watch(notificationPrefsProvider);
    final authService = ref.read(authServiceProvider);

    return SolaScaffold(
      title: 'Settings',
      padding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding,
          vertical: AppSizes.space16,
        ),
        children: [
          // ----------------------------------------------------------------
          // 1. Cycle
          // ----------------------------------------------------------------
          settingsAsync.when(
            data: (settings) => _CycleSection(settings: settings, ref: ref),
            loading: () => const _SectionSkeleton(title: 'Cycle', rows: 2),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: AppSizes.sectionGap),
          // ----------------------------------------------------------------
          // 2. Notifications
          // ----------------------------------------------------------------
          notifsAsync.when(
            data: (prefs) => _NotificationsSection(prefs: prefs, ref: ref),
            loading: () =>
                const _SectionSkeleton(title: 'Notifications', rows: 3),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: AppSizes.sectionGap),
          // ----------------------------------------------------------------
          // 3. Security
          // ----------------------------------------------------------------
          _SecuritySection(authService: authService),
          const SizedBox(height: AppSizes.sectionGap),
          // ----------------------------------------------------------------
          // 4. Data
          // ----------------------------------------------------------------
          const _DataSection(),
          const SizedBox(height: AppSizes.sectionGap),
          // ----------------------------------------------------------------
          // 5. About
          // ----------------------------------------------------------------
          const _AboutSection(),
          const SizedBox(height: AppSizes.space40),
        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------------
// Cycle section
// ---------------------------------------------------------------------------

class _CycleSection extends StatefulWidget {
  const _CycleSection({required this.settings, required this.ref});
  final Map<String, String> settings;
  final WidgetRef ref;

  @override
  State<_CycleSection> createState() => _CycleSectionState();
}

class _CycleSectionState extends State<_CycleSection> {
  late double _cycleLength;
  late double _periodLength;

  @override
  void initState() {
    super.initState();
    _cycleLength = double.tryParse(
            widget.settings[kSettingDefaultCycleLength] ?? '') ??
        28;
    _periodLength = double.tryParse(
            widget.settings[kSettingDefaultPeriodLength] ?? '') ??
        5;
  }

  Future<void> _saveCycleLength(double v) async {
    setState(() => _cycleLength = v);
    final dao = widget.ref.read(settingsDaoProvider);
    await dao.setSetting(kSettingDefaultCycleLength, v.round().toString());
  }

  Future<void> _savePeriodLength(double v) async {
    setState(() => _periodLength = v);
    final dao = widget.ref.read(settingsDaoProvider);
    await dao.setSetting(kSettingDefaultPeriodLength, v.round().toString());
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Cycle',
      children: [
        _SliderTile(
          icon: Icons.loop_rounded,
          title: 'Default cycle length',
          value: _cycleLength,
          min: 21,
          max: 45,
          unit: 'days',
          onChanged: _saveCycleLength,
        ),
        _SliderTile(
          icon: Icons.water_drop_outlined,
          title: 'Default period length',
          value: _periodLength,
          min: 2,
          max: 10,
          unit: 'days',
          onChanged: _savePeriodLength,
        ),
      ],
    );
  }
}
// ---------------------------------------------------------------------------
// Notifications section
// ---------------------------------------------------------------------------

class _NotificationsSection extends StatelessWidget {
  const _NotificationsSection({required this.prefs, required this.ref});
  final List<dynamic> prefs;
  final WidgetRef ref;

  dynamic _pref(String type) =>
      prefs.firstWhere((p) => p.type == type, orElse: () => null);

  Future<void> _toggleNotif(String type, bool enabled) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final dao = ref.read(notificationDaoProvider);
    await dao.updatePreference(
      type,
      NotificationPreferencesTableCompanion(
        enabled: Value(enabled ? 1 : 0),
        updatedAt: Value(now),
      ),
    );
    ref.invalidate(notificationPrefsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final period = _pref('period_approaching');
    final fertile = _pref('fertile_window');
    final daily = _pref('daily_reminder');

    return SettingsSection(
      title: 'Notifications',
      children: [
        SettingsTile(
          icon: Icons.calendar_today_outlined,
          title: 'Period reminder',
          subtitle: 'Get notified 2 days before predicted start',
          trailing: Switch(
            value: period?.enabled ?? false,
            onChanged: period != null
                ? (v) => _toggleNotif('period_approaching', v)
                : null,
          ),
        ),
        SettingsTile(
          icon: Icons.favorite_outline_rounded,
          title: 'Fertile window',
          subtitle: 'Off by default',
          trailing: Switch(
            value: fertile?.enabled ?? false,
            onChanged: fertile != null
                ? (v) => _toggleNotif('fertile_window', v)
                : null,
          ),
        ),
        SettingsTile(
          icon: Icons.notifications_outlined,
          title: 'Daily log reminder',
          subtitle: daily?.timeOfDay != null
              ? 'Reminds you at ${daily!.timeOfDay}'
              : 'Tap to set a reminder time',
          trailing: Switch(
            value: daily?.enabled ?? false,
            onChanged: daily != null
                ? (v) => _toggleNotif('daily_reminder', v)
                : null,
          ),
          onTap: daily?.enabled == true
              ? () => _pickReminderTime(context, daily)
              : null,
        ),
      ],
    );
  }

  Future<void> _pickReminderTime(
      BuildContext context, dynamic dailyPref) async {
    final current = dailyPref?.timeOfDay ?? '21:00';
    final parts = current.split(':');
    final initTime = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 21,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initTime,
    );
    if (picked == null) return;
    final hh = picked.hour.toString().padLeft(2, '0');
    final mm = picked.minute.toString().padLeft(2, '0');
    final timeStr = '$hh:$mm';
    final now = DateTime.now().toUtc().toIso8601String();
    final dao = ref.read(notificationDaoProvider);
    await dao.updatePreference(
      'daily_reminder',
      NotificationPreferencesTableCompanion(
        timeOfDay: Value(timeStr),
        updatedAt: Value(now),
      ),
    );
    ref.invalidate(notificationPrefsProvider);
  }
}
// ---------------------------------------------------------------------------
// Security section
// ---------------------------------------------------------------------------

class _SecuritySection extends ConsumerStatefulWidget {
  const _SecuritySection({required this.authService});
  final AuthService authService;

  @override
  ConsumerState<_SecuritySection> createState() =>
      _SecuritySectionState();
}

class _SecuritySectionState extends ConsumerState<_SecuritySection> {
  bool _biometricAvailable = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricState();
  }

  Future<void> _loadBiometricState() async {
    final available = await widget.authService.isBiometricAvailable();
    final enabled = await widget.authService.isBiometricEnabled();
    if (!mounted) return;
    setState(() {
      _biometricAvailable = available;
      _biometricEnabled = enabled;
    });
  }

  Future<void> _changePinTapped(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (_) => const PinChangeDialog(),
    );
  }

  Future<void> _toggleBiometric(bool value) async {
    if (value) {
      final success = await widget.authService.enableBiometric();
      if (!mounted) return;
      setState(() => _biometricEnabled = success);
    } else {
      await widget.authService.disableBiometric();
      if (!mounted) return;
      setState(() => _biometricEnabled = false);
    }
  }

  Future<void> _setAutoLock(BuildContext context) async {
    final current = ref.read(autoLockTimeoutProvider);
    final options = <int>[60, 300, 600, 1800, 0];
    final labels = <String>[
      "After 1 minute",
      "After 5 minutes",
      "After 10 minutes",
      "After 30 minutes",
      "Never",
    ];
    final picked = await showModalBottomSheet<int>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusCard),
        ),
      ),
      builder: (ctx) => _AutoLockSheet(
        options: options,
        labels: labels,
        current: current,
      ),
    );
    if (picked == null) return;
    final dao = ref.read(settingsDaoProvider);
    await dao.setSetting(kSettingAutoLockTimeout, picked.toString());
    ref.invalidate(settingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final autoLockSeconds = ref.watch(autoLockTimeoutProvider);
    final autoLockLabel = _autoLockLabel(autoLockSeconds);

    return SettingsSection(
      title: 'Security',
      children: [
        SettingsTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change PIN',
          subtitle: 'Update your 4-6 digit PIN',
          onTap: () => _changePinTapped(context),
        ),
        if (_biometricAvailable)
          SettingsTile(
            icon: Icons.fingerprint_rounded,
            title: 'Biometric unlock',
            subtitle: 'Use Face ID or fingerprint to unlock',
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: _toggleBiometric,
            ),
          ),
        SettingsTile(
          icon: Icons.timer_outlined,
          title: 'Auto-lock',
          subtitle: autoLockLabel,
          onTap: () => _setAutoLock(context),
        ),
      ],
    );
  }

  static String _autoLockLabel(int seconds) {
    if (seconds == 0) return 'Never';
    if (seconds < 60) return 'After $seconds seconds';
    final mins = seconds ~/ 60;
    return 'After $mins minute${mins > 1 ? "s" : ""}';
  }
}

// ---------------------------------------------------------------------------
// Data section
// ---------------------------------------------------------------------------

class _DataSection extends StatelessWidget {
  const _DataSection();

  Future<void> _onDeleteTapped(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DeleteDataDialog(),
    );
    if (confirmed == true && context.mounted) {
      context.go(RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Data',
      children: [
        const ExportSection(),
        SettingsTile(
          icon: Icons.delete_outline_rounded,
          title: 'Delete all data',
          subtitle: 'Permanently erase all cycle history and settings',
          isDestructive: true,
          onTap: () => _onDeleteTapped(context),
        ),
      ],
    );
  }
}
// ---------------------------------------------------------------------------
// About section
// ---------------------------------------------------------------------------

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'About',
      children: [
        SettingsTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () => context.push(RouteNames.privacyPolicy),
        ),
        SettingsTile(
          icon: Icons.info_outline_rounded,
          title: 'Version',
          subtitle: '1.0.0',
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.space8,
              vertical: AppSizes.space4,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius:
                  BorderRadius.circular(AppSizes.radiusPill),
            ),
            child: Text(
              'Device-local only',
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// ---------------------------------------------------------------------------
// Auto-lock bottom sheet
// ---------------------------------------------------------------------------

class _AutoLockSheet extends StatelessWidget {
  const _AutoLockSheet({
    required this.options,
    required this.labels,
    required this.current,
  });
  final List<int> options;
  final List<String> labels;
  final int current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.pagePadding,
              AppSizes.space20,
              AppSizes.pagePadding,
              AppSizes.space8,
            ),
            child: Text('Auto-lock after', style: AppTypography.heading3),
          ),
          ...List.generate(options.length, (i) {
            final selected = options[i] == current;
            return ListTile(
              title: Text(labels[i]),
              trailing: selected
                  ? const Icon(Icons.check_rounded,
                      color: AppColors.primary)
                  : null,
              onTap: () => Navigator.of(context).pop(options[i]),
            );
          }),
          const SizedBox(height: AppSizes.space8),
        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------------
// Slider tile helper
// ---------------------------------------------------------------------------

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });
  final IconData icon;
  final String title;
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.pagePadding,
        vertical: AppSizes.space12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: AppSizes.iconMedium),
              const SizedBox(width: AppSizes.space12),
              Expanded(
                child: Text(title, style: AppTypography.body1),
              ),
              Text(
                '${value.round()} $unit',
                style: AppTypography.body1.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).round(),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.primary.withAlpha(40),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------------
// Section skeleton (loading placeholder)
// ---------------------------------------------------------------------------

class _SectionSkeleton extends StatelessWidget {
  const _SectionSkeleton({required this.title, required this.rows});
  final String title;
  final int rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.pagePadding,
            bottom: AppSizes.space8,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
          ),
          child: Column(
            children: List.generate(
              rows,
              (i) => Container(
                height: AppSizes.settingsTileHeight,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.pagePadding,
                  vertical: AppSizes.space12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusSmall),
                      ),
                    ),
                    const SizedBox(width: AppSizes.space12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 14,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColors.divider,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
