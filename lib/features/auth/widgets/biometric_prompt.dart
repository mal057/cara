import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/auth_providers.dart';

/// Triggers biometric authentication automatically on first build and
/// exposes callbacks for the parent to react to the outcome.
///
/// [BiometricPrompt] is an invisible widget (zero size) that fires
/// [AuthStateNotifier.authenticateWithBiometric] once via
/// [WidgetsBinding.addPostFrameCallback] so it does not block the first
/// frame render.
///
/// Usage:
/// ```dart
/// BiometricPrompt(
///   onSuccess: () => context.go(RouteNames.calendar),
///   onFailure: () { /* increment counter, maybe show PIN */ },
/// )
/// ```
class BiometricPrompt extends ConsumerStatefulWidget {
  const BiometricPrompt({
    super.key,
    required this.onSuccess,
    required this.onFailure,
  });

  /// Called when biometric authentication succeeds.
  final VoidCallback onSuccess;

  /// Called when biometric authentication fails or the user cancels.
  final VoidCallback onFailure;

  @override
  ConsumerState<BiometricPrompt> createState() => _BiometricPromptState();
}

class _BiometricPromptState extends ConsumerState<BiometricPrompt> {
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasTriggered && mounted) {
        _hasTriggered = true;
        _triggerBiometric();
      }
    });
  }

  Future<void> _triggerBiometric() async {
    final success =
        await ref.read(authStateProvider.notifier).authenticateWithBiometric();
    if (!mounted) return;
    if (success) {
      widget.onSuccess();
    } else {
      widget.onFailure();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This widget is invisible — it only triggers the auth side-effect.
    return const SizedBox.shrink();
  }
}
