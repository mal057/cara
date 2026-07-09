import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/database_provider.dart';
import '../../auth/widgets/pin_input.dart';
import '../../onboarding/widgets/pin_pad.dart';
import '../../shared/widgets/cara_button.dart';

/// The two steps in the delete-data confirmation flow.
enum _DeleteStep { warning, pin }

/// Confirmation dialog for the irreversible 'Delete All Data' action.
///
/// Step 1 – Warning: shows consequences of deletion with a red danger card.
/// Step 2 – PIN entry: user must re-enter their PIN to confirm deletion.
///
/// On confirmation:
///   1. Calls [AuthService.deleteAllData] to wipe PIN and encryption key.
///   2. Closes the database via ProviderContainer invalidation.
///   3. Navigates to onboarding (app resets to first-run state).
///
/// Returns true on success, false/null on cancel.
class DeleteDataDialog extends ConsumerStatefulWidget {
  const DeleteDataDialog({super.key});

  @override
  ConsumerState<DeleteDataDialog> createState() => _DeleteDataDialogState();
}

class _DeleteDataDialogState extends ConsumerState<DeleteDataDialog> {
  _DeleteStep _step = _DeleteStep.warning;
  String _pin = '';
  String? _errorMessage;
  bool _isDeleting = false;

  final _shakeKey = GlobalKey<PinInputState>();

  static const int _maxPin = 6;
  static const int _minPin = 4;
  void _onDigit(String digit) {
    if (_pin.length >= _maxPin) return;
    setState(() {
      _errorMessage = null;
      _pin += digit;
    });
    if (_pin.length == _maxPin) _handleDelete();
  }

  void _onBackspace() {
    setState(() {
      _errorMessage = null;
      if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
    });
  }

  Future<void> _handleDelete() async {
    if (_pin.length < _minPin) {
      setState(() => _errorMessage = 'PIN must be at least $_minPin digits');
      _shakeKey.currentState?.shake();
      return;
    }
    if (_isDeleting) return;
    setState(() => _isDeleting = true);

    final pinManager = ref.read(pinManagerProvider);
    final valid = await pinManager.verifyPin(_pin);
    if (!mounted) return;

    if (!valid) {
      setState(() {
        _pin = '';
        _errorMessage = 'Incorrect PIN. All data was NOT deleted.';
        _isDeleting = false;
      });
      _shakeKey.currentState?.shake();
      return;
    }

    try {
      final authService = ref.read(authServiceProvider);
      await authService.deleteAllData();
      if (!mounted) return;
      // Invalidate database so the next open re-initialises.
      ref.invalidate(databaseProvider);
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isDeleting = false;
        _pin = '';
        _errorMessage = 'Deletion failed. Please try again.';
      });
      _shakeKey.currentState?.shake();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: switch (_step) {
          _DeleteStep.warning => _buildWarningStep(),
          _DeleteStep.pin => _buildPinStep(),
        },
      ),
    );
  }

  Widget _buildWarningStep() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const SizedBox(width: AppSizes.space8),
              Text('Delete All Data', style: AppTypography.heading3),
            ],
          ),
          const SizedBox(height: AppSizes.space32),
          // Danger card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.space20),
            decoration: BoxDecoration(
              color: AppColors.error.withAlpha(13),
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
              border: Border.all(color: AppColors.error.withAlpha(76)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: AppColors.error, size: AppSizes.iconLarge),
                    const SizedBox(width: AppSizes.space12),
                    Expanded(
                      child: Text(
                        'This action cannot be undone',
                        style: AppTypography.heading3
                            .copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.space16),
                Text(
                  'Deleting all data will permanently erase:',
                  style: AppTypography.body2
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSizes.space12),
                ..._consequences.map((c) => _BulletRow(text: c)),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.space24),
          Text(
            'You will be taken back to the setup screen. There is no way to recover your data after this.',
            style:
                AppTypography.body2.copyWith(color: AppColors.textSecondary),
          ),
          const Spacer(),
          CaraButton(
            label: 'Delete All Data',
            variant: CaraButtonVariant.danger,
            icon: Icons.delete_forever_rounded,
            isFullWidth: true,
            onPressed: () => setState(() => _step = _DeleteStep.pin),
          ),
          const SizedBox(height: AppSizes.space12),
          CaraButton(
            label: 'Cancel',
            variant: CaraButtonVariant.secondary,
            isFullWidth: true,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
  Widget _buildPinStep() {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.pagePadding,
        right: AppSizes.pagePadding,
        top: AppSizes.space8,
        bottom: bottomInset + AppSizes.space16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => setState(() {
                  _step = _DeleteStep.warning;
                  _pin = '';
                  _errorMessage = null;
                }),
              ),
              const SizedBox(width: AppSizes.space8),
              Text('Confirm Deletion', style: AppTypography.heading3),
            ],
          ),
          const SizedBox(height: AppSizes.space24),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.error.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.delete_forever_rounded,
                color: AppColors.error, size: AppSizes.iconLarge),
          ),
          const SizedBox(height: AppSizes.space16),
          Text(
            'Enter your PIN to confirm',
            style: AppTypography.heading2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.space8),
          Text(
            'This will permanently delete all your cycle data, notes, and settings.',
            style:
                AppTypography.body2.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.space32),
          PinInput(
            key: _shakeKey,
            pinLength: _pin.length,
            maxLength: _maxPin,
            errorMessage: _errorMessage,
            dotColor: AppColors.error,
          ),
          const Spacer(),
          PinPad(onDigit: _onDigit, onBackspace: _onBackspace),
          const SizedBox(height: AppSizes.space16),
          ElevatedButton(
            onPressed: _isDeleting ? null : _handleDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.surface,
              minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              ),
            ),
            child: _isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.surface))
                : const Text('Delete All Data'),
          ),
        ],
      ),
    );
  }

  static const List<String> _consequences = [
    'All period logs and cycle history',
    'All symptom entries and daily notes',
    'Notification preferences',
    'Your PIN and biometric settings',
    'The encryption key (data becomes inaccessible)',
  ];
}

/// A single bullet row in the consequences list.
class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: AppSizes.space8),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
