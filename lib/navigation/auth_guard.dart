import 'package:go_router/go_router.dart';

import '../providers/auth_providers.dart';
import 'route_names.dart';

/// Redirect logic for the Sola GoRouter auth guard.
///
/// Called on every navigation attempt (including refreshes triggered by
/// [AuthState] changes). Returns a redirect path when the current navigation
/// is not permitted for the current auth state, or `null` to allow it.
///
/// Rules (evaluated top-to-bottom):
/// 1. Not onboarded → redirect to [RouteNames.onboarding] regardless of
///    destination, unless already navigating within the onboarding flow.
/// 2. Onboarded but locked → redirect to [RouteNames.lock] unless already
///    on the lock screen.
/// 3. Authenticated → allow; return `null`.
///
/// This function is a plain function (not a class) so it can be passed
/// directly to [GoRouter.redirect].
String? authGuard({
  required GoRouterState state,
  required AuthState authState,
}) {
  final String location = state.matchedLocation;

  final bool onOnboarding = location.startsWith(RouteNames.onboarding);
  final bool onLock = location == RouteNames.lock;

  // Rule 1: Onboarding not complete — funnel to onboarding.
  if (!authState.isOnboardingComplete) {
    return onOnboarding ? null : RouteNames.onboarding;
  }

  // Rule 2: Onboarding complete but app is locked — funnel to lock screen.
  if (!authState.isAuthenticated || authState.isLocked) {
    return onLock ? null : RouteNames.lock;
  }

  // Rule 3: Authenticated — no redirect needed.
  // Prevent authenticated users from landing back on onboarding or lock.
  if (onOnboarding) return RouteNames.calendar;
  if (onLock) return RouteNames.calendar;

  return null;
}
