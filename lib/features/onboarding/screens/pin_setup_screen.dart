import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../navigation/route_names.dart';
import '../../../providers/auth_providers.dart';
import '../../../services/auth/auth_service.dart';
import '../../shared/widgets/sola_button.dart';
import '../../shared/widgets/ocean_background/ocean_background.dart';
import '../widgets/pin_pad.dart';

const int _minPinLength = 4;
const int _maxPinLength = 6;

/// PIN creation step within the onboarding wizard.
///
/// Two-phase flow:
///   1. Create: user enters a 4-6 digit PIN.
///   2. Confirm: user re-enters the same PIN.
///
/// If the PINs match, [AuthService.setupPin] is called to store the hashed PIN
/// and generate the database encryption key. Navigation advances to
/// [RouteNames.biometricSetup]. A shake animation plays on mismatch.
class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key});

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen>
    with SingleTickerProviderStateMixin {
  String _createPin = '';
  String _confirmPin = '';
  bool _isConfirming = false;
  bool _isLoading = false;
  String? _errorMessage;

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  String get _currentPin => _isConfirming ? _confirmPin : _createPin;

  void _appendDigit(String digit) {
    if (_currentPin.length >= _maxPinLength) return;
    setState(() {
      _errorMessage = null;
      if (_isConfirming) {
        _confirmPin += digit;
      } else {
        _createPin += digit;
      }
    });
    if (_currentPin.length == _maxPinLength) {
      _onPinComplete();
    }
  }

  void _deleteDigit() {
    if (_currentPin.isEmpty) return;
    setState(() {
      _errorMessage = null;
      if (_isConfirming) {
        _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
      } else {
        _createPin = _createPin.substring(0, _createPin.length - 1);
      }
    });
  }

  void _onContinueTapped() {
    if (_currentPin.length < _minPinLength) {
      setState(() {
        _errorMessage = 'PIN must be at least $_minPinLength digits';
      });
      return;
    }
    _onPinComplete();
  }
  Future<void> _onPinComplete() async {
    if (!_isConfirming) {
      setState(() {
        _isConfirming = true;
        _confirmPin = '';
        _errorMessage = null;
      });
      return;
    }
    if (_confirmPin != _createPin) {
      setState(() {
        _errorMessage = 'PINs do not match. Please try again.';
        _confirmPin = '';
      });
      _shakeController.forward(from: 0);
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final authService = ref.read(authServiceProvider);
      await authService.setupPin(_createPin);
      if (!mounted) return;
      context.go(RouteNames.biometricSetup);
    } on ArgumentError catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to save PIN. Please try again.';
      });
    }
  }

  void _goBack() {
    if (_isConfirming) {
      setState(() {
        _isConfirming = false;
        _confirmPin = '';
        _errorMessage = null;
      });
    } else {
      context.go(RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        _isConfirming ? 'Confirm your PIN' : 'Create your PIN';
    final String subtitle = _isConfirming
        ? 'Enter the same PIN again to confirm'
        : 'Choose a $_minPinLength-$_maxPinLength digit PIN to protect your data';

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
          onPressed: _isLoading ? null : _goBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.space24),
              Text(title, style: AppTypography.heading2, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.space8),
              Text(
                subtitle,
                style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.space40),
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(_shakeAnimation.value, 0),
                  child: child,
                ),
                child: _PinDots(
                  enteredLength: _currentPin.length,
                  maxLength: _maxPinLength,
                  hasError: _errorMessage != null,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: AppSizes.animFast),
                child: _errorMessage != null
                    ? Padding(
                        key: ValueKey(_errorMessage),
                        padding: const EdgeInsets.only(top: AppSizes.space16),
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.caption.copyWith(color: AppColors.error),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(key: ValueKey('empty'), height: AppSizes.space32),
              ),
              const SizedBox(height: AppSizes.space16),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: PinPad(
                      onDigit: _isLoading ? (_) {} : _appendDigit,
                      onBackspace: _isLoading ? () {} : _deleteDigit,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.space24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: AppSizes.animFast),
                child: _currentPin.length >= _minPinLength
                    ? SolaButton(
                        key: const ValueKey('continue'),
                        label: _isConfirming ? 'Set PIN' : 'Continue',
                        onPressed: _isLoading ? null : _onContinueTapped,
                        isFullWidth: true,
                        isLoading: _isLoading,
                      )
                    : SizedBox(
                        key: const ValueKey('empty_btn'),
                        height: AppSizes.buttonHeight,
                      ),
              ),
              const SizedBox(height: AppSizes.space32),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({
    required this.enteredLength,
    required this.maxLength,
    required this.hasError,
  });

  final int enteredLength;
  final int maxLength;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (i) {
        final bool filled = i < enteredLength;
        final Color color = hasError
            ? AppColors.error
            : (filled ? AppColors.primary : AppColors.primary.withAlpha(40));
        return AnimatedContainer(
          duration: const Duration(milliseconds: AppSizes.animFast),
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.space8),
          width: AppSizes.pinDotSize,
          height: AppSizes.pinDotSize,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      }),
    );
  }
}
