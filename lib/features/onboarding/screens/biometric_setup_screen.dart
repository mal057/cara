import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';
import '../../../navigation/route_names.dart';
import '../../../providers/auth_providers.dart';
import '../../../services/auth/auth_service.dart';
import '../../shared/widgets/cara_button.dart';
import '../../shared/widgets/ocean_background/ocean_background.dart';

/// Biometric opt-in step within the onboarding wizard (skippable).
///
/// Checks device biometric availability on init; auto-skips if unavailable.
/// Enable triggers [AuthService.enableBiometric] (system biometric prompt).
/// Skip proceeds directly to [RouteNames.cycleSetup].
class BiometricSetupScreen extends ConsumerWidget {
  const BiometricSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BiometricSetupContent();
  }
}

class _BiometricSetupContent extends StatefulWidget {
  @override
  State<_BiometricSetupContent> createState() => _BiometricSetupContentState();
}

class _BiometricSetupContentState extends State<_BiometricSetupContent> {
  bool _isLoading = false;
  bool _checkingAvailability = true;
  bool _enrolled = false;
  String? _errorMessage;
  bool _hasChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasChecked) {
      _hasChecked = true;
      _checkBiometricAvailability();
    }
  }

  Future<void> _checkBiometricAvailability() async {
    final container = ProviderScope.containerOf(context);
    final authService = container.read(authServiceProvider);
    try {
      final available = await authService.isBiometricAvailable();
      if (!mounted) return;
      if (!available) {
        context.go(RouteNames.cycleSetup);
        return;
      }
      setState(() {
        _checkingAvailability = false;
      });
    } catch (_) {
      if (!mounted) return;
      context.go(RouteNames.cycleSetup);
    }
  }

  Future<void> _onEnable() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final container = ProviderScope.containerOf(context);
    final authService = container.read(authServiceProvider);
    try {
      final success = await authService.enableBiometric();
      if (!mounted) return;
      if (success) {
        setState(() => _enrolled = true);
        await Future<void>.delayed(const Duration(milliseconds: 800));
        if (!mounted) return;
        context.go(RouteNames.cycleSetup);
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Biometric was not confirmed. Enable it later in Settings.';
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not enable biometrics. Try again in Settings.';
      });
    }
  }

  void _onSkip() => context.go(RouteNames.cycleSetup);
  @override
  Widget build(BuildContext context) {
    if (_checkingAvailability) {
      return OceanBackground(
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
        ),
      );
    }

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
            onPressed: _isLoading ? null : () => context.go(RouteNames.pinSetup),
          ),
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.space48),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: AppSizes.animStandard),
                child: _enrolled
                    ? Container(
                        key: const ValueKey('enrolled'),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.success.withAlpha(25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          size: 56,
                          color: AppColors.success,
                        ),
                      )
                    : Container(
                        key: const ValueKey('biometric'),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _biometricIcon(),
                          size: 52,
                          color: AppColors.primary,
                          semanticLabel: 'Biometric authentication',
                        ),
                      ),
              ),
              const SizedBox(height: AppSizes.space32),
              Text(
                _enrolled ? 'Biometrics Enabled' : 'Enable Biometrics',
                style: AppTypography.heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.space16),
              Text(
                _enrolled
                    ? 'You can now use biometrics to unlock Cara quickly.'
                    : 'Unlock Cara with your fingerprint or face. '
                        'Your biometric data never leaves this device.',
                style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
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
              const Spacer(),
              if (!_enrolled) ...[
                CaraButton(
                  label: 'Enable Biometrics',
                  icon: _biometricIcon(),
                  onPressed: _isLoading ? null : _onEnable,
                  isFullWidth: true,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppSizes.space12),
                TextButton(
                  onPressed: _isLoading ? null : _onSkip,
                  child: Text(
                    'Skip for now',
                    style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ],
              const SizedBox(height: AppSizes.space32),
            ],
          ),
        ),
      ),
    ),
    );
  }

  IconData _biometricIcon() {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return Icons.face_retouching_natural;
    }
    return Icons.fingerprint;
  }
}

