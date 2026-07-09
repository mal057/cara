import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../shared/widgets/cara_scaffold.dart';

/// Scrollable in-app privacy policy screen.
///
/// Displays the full Cara privacy policy as hardcoded text. No WebView,
/// no network calls. All content lives locally in this widget.
///
/// Reached from Settings > About > Privacy Policy.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CaraScaffold(
      title: 'Privacy Policy',
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding,
          vertical: AppSizes.space24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PrivacyHero(),
            const SizedBox(height: AppSizes.space32),
            _Section(
              title: 'The short version',
              body:
                  'Cara knows nothing about you that you haven\'t typed in yourself. '
                  'Your data never leaves your phone. There is no account to create, '
                  'no server to talk to, and no company waiting to monetise your cycle data. '
                  'Everything stays on your device, encrypted.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'What Cara stores',
              body: 'Cara only saves information you deliberately enter:',
              bullets: const [
                'Period start and end dates',
                'Flow intensity and color notes',
                'Symptom logs (mood, pain, energy, sleep, and others)',
                'Free-text daily notes (up to 500 characters)',
                'Cycle length and period length preferences',
                'Notification preferences',
                'Your PIN (stored as a salted SHA-256 hash, never in plain text)',
              ],
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Where your data lives',
              body:
                  'All data is stored in a single SQLite database file on your device. '
                  'That file is encrypted with AES-256 using SQLCipher. The encryption key '
                  'is generated on first launch, stored in your device\'s secure hardware keystore '
                  '(Android Keystore or iOS Keychain), and never leaves the device. '
                  'If you delete the app, the key is deleted with it and the encrypted '
                  'database becomes permanently unreadable.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'What Cara never does',
              body: 'These are promises, not fine print:',
              bullets: const [
                'No internet connection. Cara has no INTERNET permission on Android and no App Transport Security entry on iOS. It literally cannot reach the internet.',
                'No analytics. No Firebase, no Mixpanel, no Amplitude, no crash reporters.',
                'No advertising SDKs of any kind.',
                'No location data. Cara never asks for or uses your location.',
                'No device identifiers. No advertising ID, no IMEI, no MAC address.',
                'No cloud sync. Your data is never uploaded anywhere, not even encrypted.',
                'No telemetry. Cara does not phone home, ever.',
                'No third-party SDKs that collect data. Every dependency is open source and network-silent.',
              ],
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Notifications',
              body:
                  'If you enable reminders, Cara schedules local notifications entirely on-device. '
                  'No notification server is involved. Notifications are generated and delivered '
                  'by your operating system using data already stored locally. '
                  'You can disable all notifications at any time in Settings.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Exporting your data',
              body:
                  'You are in complete control of your data. From Settings, '
                  'you can generate a CSV or PDF report of your cycle history. '
                  'That file is created locally and shared through your operating system\'s '
                  'standard share sheet, so you choose where it goes. '
                  'Cara does not keep a copy and does not know where you sent it.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Deleting your data',
              body:
                  'You can permanently delete all your data at any time from Settings. '
                  'This wipes the encrypted database, deletes the encryption key from secure storage, '
                  'and resets the app to its initial state. The deletion is immediate and irreversible. '
                  'There is no backup to restore from, because there never was one.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Children and privacy',
              body:
                  'Cara is not directed at children under 13. We do not knowingly collect '
                  'information from children. Because Cara collects nothing at all, '
                  'this is straightforward: no data from anyone is ever transmitted.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Changes to this policy',
              body:
                  'If this policy ever changes, the updated version will be included in '
                  'the app update. Because no data is collected remotely, we have no way '
                  'to notify you directly, which is also why you can trust us.',
            ),
            const SizedBox(height: AppSizes.sectionGap),
            _Section(
              title: 'Contact',
              body:
                  'Questions, concerns, or feedback about privacy? '
                  'Reach us at privacy@cara.app. We read every message.',
            ),
            const SizedBox(height: AppSizes.space32),
            _EffectiveDate(),
            const SizedBox(height: AppSizes.space40),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private sub-widgets
// ---------------------------------------------------------------------------

/// Hero banner that summarises the core privacy promise before the user
/// reads the detailed policy sections.
class _PrivacyHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.space24),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(13),
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(
          color: AppColors.primary.withAlpha(38),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.primary,
                size: AppSizes.iconLarge,
              ),
              const SizedBox(width: AppSizes.space12),
              Expanded(
                child: Text(
                  'Your data never leaves this device',
                  style: AppTypography.heading3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.space12),
          Text(
            'No internet. No cloud. No analytics. No accounts. '
            'Cara is a privacy-first app in the truest sense. '
            'It has no capability to collect your data even if it wanted to.',
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

/// A single policy section with a heading, optional intro paragraph,
/// and an optional bullet list.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.body,
    this.bullets,
  });

  final String title;
  final String body;
  final List<String>? bullets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.heading3,
        ),
        const SizedBox(height: AppSizes.space8),
        Text(
          body,
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        if (bullets != null) ...[
          const SizedBox(height: AppSizes.space12),
          ...bullets!.map((bullet) => _BulletItem(text: bullet)),
        ],
      ],
    );
  }
}

/// A single bullet-point row with a small colored dot and body text.
class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 7.0,
              right: AppSizes.space8,
            ),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Footer showing the effective date of this policy version.
class _EffectiveDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Effective date: February 2026',
      style: AppTypography.caption.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }
}
