import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../providers/auth_providers.dart';
import '../../../navigation/route_names.dart';
import '../widgets/biometric_prompt.dart';
import '../widgets/pin_input.dart';
import '../../shared/widgets/ocean_background/ocean_background.dart';

const int _kMaxPinLength = 4;
const int _kMaxBiometricAttempts = 3;

/// Full-screen lock screen shown on cold start and after the auto-lock timeout.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen>
    with TickerProviderStateMixin {
  final _shakeKey = GlobalKey<PinInputState>();
  String _pin = '';
  String? _errorMessage;
  bool _biometricActive = true;
  int _biometricFailures = 0;
  bool _showPin = false;
  bool _verifying = false;

  // Breathing animation for the fingerprint icon.
  late final AnimationController _breathController;
  late final Animation<double> _breathAnimation;

  bool get _biometricExhausted => _biometricFailures >= _kMaxBiometricAttempts;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _breathAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breathController.dispose();
    super.dispose();
  }

  void _onBiometricSuccess() {
    if (!mounted) return;
    context.go(RouteNames.calendar);
  }

  void _onBiometricFailure() {
    if (!mounted) return;
    setState(() {
      _biometricFailures++;
      _biometricActive = false;
      if (_biometricExhausted) {
        _showPin = true;
      }
    });
  }

  void _switchToPin() {
    setState(() {
      _showPin = true;
      _biometricActive = false;
      _errorMessage = null;
    });
  }

  void _retryBiometric() {
    setState(() {
      _biometricActive = true;
      _showPin = false;
      _errorMessage = null;
    });
  }

  void _onDigitTapped(String digit) {
    if (_verifying) return;
    if (_pin.length >= _kMaxPinLength) return;
    HapticFeedback.lightImpact();
    setState(() {
      _pin += digit;
      _errorMessage = null;
    });
    if (_pin.length == _kMaxPinLength) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_verifying) return;
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _errorMessage = null;
    });
  }

  Future<void> _verifyPin() async {
    if (_verifying) return;
    setState(() => _verifying = true);
    final success =
        await ref.read(authStateProvider.notifier).authenticateWithPin(_pin);
    if (!mounted) return;
    if (success) {
      context.go(RouteNames.calendar);
      return;
    }
    await _shakeKey.currentState?.shake();
    setState(() {
      _pin = '';
      _errorMessage = 'Incorrect PIN';
      _verifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OceanBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
        child: Stack(
          children: [
            // Subtle radial depth glow behind the branding area.
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withAlpha(18),
                        AppColors.background.withAlpha(0),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            if (_biometricActive)
              BiometricPrompt(
                key: ValueKey(_biometricFailures),
                onSuccess: _onBiometricSuccess,
                onFailure: _onBiometricFailure,
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                _buildBranding(),
                const SizedBox(height: AppSizes.space48),
                if (_showPin) ...[
                  _buildPinDots(),
                  const SizedBox(height: AppSizes.space48),
                  _buildNumericPad(),
                  const SizedBox(height: AppSizes.space32),
                  _buildBiometricRetryButton(),
                ] else ...[
                  _buildBiometricWaiting(),
                ],
                const Spacer(flex: 3),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildBranding() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Lock icon with radial gradient background and soft outer glow.
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withAlpha(160),
              ],
              stops: const [0.0, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(55),
                blurRadius: 28,
                spreadRadius: 4,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.primary.withAlpha(25),
                blurRadius: 48,
                spreadRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_rounded,
            color: Colors.white,
            size: AppSizes.iconLarge,
            semanticLabel: 'Cara app icon',
          ),
        ),

        const SizedBox(height: AppSizes.space20),

        // "Cara" wordmark with soft shadow for depth.
        Text(
          'Cara',
          textAlign: TextAlign.center,
          style: AppTypography.heading1.copyWith(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
            shadows: const [
              Shadow(
                color: Colors.black38,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizes.space8),

        Text(
          'Your cycle. Your data.',
          textAlign: TextAlign.center,
          style: AppTypography.body2.copyWith(
            color: Colors.white.withAlpha(200),
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }

  Widget _buildBiometricWaiting() {
    final bool canRetry = !_biometricActive && !_biometricExhausted;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pulsing fingerprint icon.
        ScaleTransition(
          scale: _biometricActive ? _breathAnimation : const AlwaysStoppedAnimation(1.0),
          child: Semantics(
            label: _biometricActive
                ? 'Waiting for biometric authentication'
                : 'Biometric authentication failed',
            child: Icon(
              Icons.fingerprint_rounded,
              size: 64,
              color: _biometricActive
                  ? Colors.white
                  : Colors.white.withAlpha(150),
            ),
          ),
        ),

        const SizedBox(height: AppSizes.space20),

        AnimatedSwitcher(
          duration: Duration(milliseconds: AppSizes.animStandard),
          child: Text(
            _biometricActive ? 'Authenticating...' : 'Biometric failed',
            key: ValueKey(_biometricActive),
            textAlign: TextAlign.center,
            style: AppTypography.body2.copyWith(
              color: Colors.white.withAlpha(200),
              letterSpacing: 0.3,
            ),
          ),
        ),

        const SizedBox(height: AppSizes.space32),

        if (canRetry) ...[
          TextButton(
            onPressed: _retryBiometric,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.space24,
                vertical: AppSizes.space12,
              ),
            ),
            child: Text(
              'Try again',
              textAlign: TextAlign.center,
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.space8),
        ],

        TextButton(
          onPressed: _switchToPin,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.space24,
              vertical: AppSizes.space12,
            ),
          ),
          child: Text(
            'Use PIN instead',
            textAlign: TextAlign.center,
            style: AppTypography.button.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinDots() {
    return PinInput(
      key: _shakeKey,
      pinLength: _pin.length,
      maxLength: _kMaxPinLength,
      errorMessage: _errorMessage,
    );
  }

  Widget _buildBiometricRetryButton() {
    if (_biometricExhausted) return const SizedBox.shrink();
    return TextButton.icon(
      onPressed: _retryBiometric,
      icon: const Icon(Icons.fingerprint_rounded, color: AppColors.primary),
      label: Text(
        'Use biometric',
        style: AppTypography.button.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildNumericPad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPadRow(['1', '2', '3']),
          const SizedBox(height: AppSizes.space20),
          _buildPadRow(['4', '5', '6']),
          const SizedBox(height: AppSizes.space20),
          _buildPadRow(['7', '8', '9']),
          const SizedBox(height: AppSizes.space20),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildPadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: digits
          .map((d) => _PinKey(digit: d, onTap: () => _onDigitTapped(d)))
          .toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Empty placeholder matching _PinKey width + padding.
        SizedBox(width: AppSizes.pinKeySize + AppSizes.space16 * 2),
        _PinKey(digit: '0', onTap: () => _onDigitTapped('0')),
        SizedBox(
          width: AppSizes.pinKeySize + AppSizes.space16 * 2,
          height: AppSizes.pinKeySize,
          child: Center(
            child: Semantics(
              label: 'Delete last digit',
              button: true,
              child: IconButton(
                onPressed: _onBackspace,
                icon: const Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                ),
                iconSize: AppSizes.iconLarge,
                splashRadius: AppSizes.pinKeySize / 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A single numeric key on the PIN pad with a press-scale animation.
class _PinKey extends StatefulWidget {
  const _PinKey({required this.digit, required this.onTap});

  final String digit;
  final VoidCallback onTap;

  @override
  State<_PinKey> createState() => _PinKeyState();
}

class _PinKeyState extends State<_PinKey>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _pressController.forward();
    widget.onTap();
    if (mounted) {
      await _pressController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.space16),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: AppSizes.pinKeySize,
          height: AppSizes.pinKeySize,
          child: Semantics(
            label: widget.digit,
            button: true,
            child: GestureDetector(
              onTap: _handleTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(30),
                  border: Border.all(
                    color: Colors.white.withAlpha(60),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withAlpha(18),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: AppColors.textPrimary.withAlpha(8),
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.digit,
                    style: AppTypography.pinDigit.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
