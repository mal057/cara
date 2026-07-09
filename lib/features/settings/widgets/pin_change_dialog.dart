import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../providers/auth_providers.dart';
import '../../auth/widgets/pin_input.dart';
import '../../onboarding/widgets/pin_pad.dart';

enum _PinChangeStep { current, newPin, confirm }

class PinChangeDialog extends ConsumerStatefulWidget {
  const PinChangeDialog({super.key});

  @override
  ConsumerState<PinChangeDialog> createState() => _PinChangeDialogState();
}

class _PinChangeDialogState extends ConsumerState<PinChangeDialog> {
  _PinChangeStep _step = _PinChangeStep.current;
  String _currentPin = '';
  String _newPin = '';
  String _confirmPin = '';
  String? _errorMessage;
  bool _isVerifying = false;

  final _currentShakeKey = GlobalKey<PinInputState>();
  final _newShakeKey = GlobalKey<PinInputState>();
  final _confirmShakeKey = GlobalKey<PinInputState>();

  static const int _maxPin = 6;
  static const int _minPin = 4;
  String get _activePin {
    switch (_step) {
      case _PinChangeStep.current: return _currentPin;
      case _PinChangeStep.newPin: return _newPin;
      case _PinChangeStep.confirm: return _confirmPin;
    }
  }

  GlobalKey<PinInputState> get _activeShakeKey {
    switch (_step) {
      case _PinChangeStep.current: return _currentShakeKey;
      case _PinChangeStep.newPin: return _newShakeKey;
      case _PinChangeStep.confirm: return _confirmShakeKey;
    }
  }

  String get _stepTitle {
    switch (_step) {
      case _PinChangeStep.current: return 'Enter current PIN';
      case _PinChangeStep.newPin: return 'Enter new PIN';
      case _PinChangeStep.confirm: return 'Confirm new PIN';
    }
  }

  String _stepSubtitle() {
    switch (_step) {
      case _PinChangeStep.current:
        return 'Verify your identity before changing your PIN.';
      case _PinChangeStep.newPin:
        return 'Choose a new 4-6 digit PIN.';
      case _PinChangeStep.confirm:
        return 'Enter your new PIN again to confirm.';
    }
  }
  void _onDigit(String digit) {
    if (_activePin.length >= _maxPin) return;
    setState(() {
      _errorMessage = null;
      switch (_step) {
        case _PinChangeStep.current: _currentPin += digit; break;
        case _PinChangeStep.newPin: _newPin += digit; break;
        case _PinChangeStep.confirm: _confirmPin += digit; break;
      }
    });
    if (_activePin.length == _maxPin) _handleAutoAdvance();
  }

  void _onBackspace() {
    setState(() {
      _errorMessage = null;
      switch (_step) {
        case _PinChangeStep.current:
          if (_currentPin.isNotEmpty) {
            _currentPin = _currentPin.substring(0, _currentPin.length - 1);
          }
          break;
        case _PinChangeStep.newPin:
          if (_newPin.isNotEmpty) {
            _newPin = _newPin.substring(0, _newPin.length - 1);
          }
          break;
        case _PinChangeStep.confirm:
          if (_confirmPin.isNotEmpty) {
            _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
          }
          break;
      }
    });
  }

  Future<void> _handleAutoAdvance() async {
    switch (_step) {
      case _PinChangeStep.current: await _verifyCurrentPin(); break;
      case _PinChangeStep.newPin:
        if (_newPin.length >= _minPin) {
          setState(() => _step = _PinChangeStep.confirm);
        }
        break;
      case _PinChangeStep.confirm: await _confirmNewPin(); break;
    }
  }

  Future<void> _onContinue() async {
    if (_activePin.length < _minPin) {
      setState(() => _errorMessage = 'PIN must be at least $_minPin digits');
      _activeShakeKey.currentState?.shake();
      return;
    }
    await _handleAutoAdvance();
  }
  Future<void> _verifyCurrentPin() async {
    if (_isVerifying) return;
    setState(() => _isVerifying = true);
    final pinManager = ref.read(pinManagerProvider);
    final valid = await pinManager.verifyPin(_currentPin);
    if (!mounted) return;
    setState(() => _isVerifying = false);
    if (valid) {
      setState(() { _step = _PinChangeStep.newPin; _errorMessage = null; });
    } else {
      setState(() {
        _currentPin = '';
        _errorMessage = 'Incorrect PIN. Try again.';
      });
      _currentShakeKey.currentState?.shake();
    }
  }

  Future<void> _confirmNewPin() async {
    if (_newPin != _confirmPin) {
      setState(() {
        _confirmPin = '';
        _errorMessage = 'PINs do not match. Try again.';
      });
      _confirmShakeKey.currentState?.shake();
      return;
    }
    if (_isVerifying) return;
    setState(() => _isVerifying = true);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.changePIn(_currentPin, _newPin);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _errorMessage = 'Failed to update PIN. Please try again.';
      });
      _confirmShakeKey.currentState?.shake();
    }
  }
  void _onBack() {
    switch (_step) {
      case _PinChangeStep.current:
        Navigator.of(context).pop(false);
        break;
      case _PinChangeStep.newPin:
        setState(() {
          _step = _PinChangeStep.current;
          _currentPin = '';
          _newPin = '';
          _errorMessage = null;
        });
        break;
      case _PinChangeStep.confirm:
        setState(() {
          _step = _PinChangeStep.newPin;
          _newPin = '';
          _confirmPin = '';
          _errorMessage = null;
        });
        break;
    }
  }

  Widget _buildPinInput() {
    switch (_step) {
      case _PinChangeStep.current:
        return PinInput(key: _currentShakeKey,
            pinLength: _currentPin.length,
            maxLength: _maxPin, errorMessage: _errorMessage);
      case _PinChangeStep.newPin:
        return PinInput(key: _newShakeKey,
            pinLength: _newPin.length,
            maxLength: _maxPin, errorMessage: _errorMessage);
      case _PinChangeStep.confirm:
        return PinInput(key: _confirmShakeKey,
            pinLength: _confirmPin.length,
            maxLength: _maxPin, errorMessage: _errorMessage);
    }
  }
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Dialog.fullscreen(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
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
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textPrimary,
                    tooltip: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  const Spacer(),
                  _StepIndicator(
                    currentStep: _step.index,
                    totalSteps: _PinChangeStep.values.length,
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: AppSizes.space32),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock_reset_rounded,
                    color: AppColors.primary, size: AppSizes.iconLarge),
              ),
              const SizedBox(height: AppSizes.space24),
              AnimatedSwitcher(
                duration: Duration(milliseconds: AppSizes.animStandard),
                child: Text(_stepTitle, key: ValueKey(_step),
                    style: AppTypography.heading2,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: AppSizes.space8),
              Text(_stepSubtitle(),
                  style: AppTypography.body2
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.space32),
              _buildPinInput(),
              const Spacer(),
              PinPad(onDigit: _onDigit, onBackspace: _onBackspace),
              const SizedBox(height: AppSizes.space16),
              Row(
                children: [
                  if (_step != _PinChangeStep.current) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onBack,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          minimumSize: const Size(0, AppSizes.buttonHeight),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusPill),
                          ),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.space12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isVerifying ? null : _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.surface,
                        minimumSize: const Size(0, AppSizes.buttonHeight),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusPill),
                        ),
                      ),
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.surface))
                          : Text(
                              _step == _PinChangeStep.confirm
                                  ? 'Change PIN'
                                  : 'Continue',
                              style: AppTypography.button),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Progress dots showing current step in the PIN change flow.
class _StepIndicator extends StatelessWidget {
  const _StepIndicator(
      {required this.currentStep, required this.totalSteps});
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (i) {
        final active = i <= currentStep;
        return AnimatedContainer(
          duration: Duration(milliseconds: AppSizes.animStandard),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20.0 : 8.0,
          height: 8,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.divider,
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          ),
        );
      }),
    );
  }
}
