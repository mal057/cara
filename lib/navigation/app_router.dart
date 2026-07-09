import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/lock_screen.dart';
import '../features/calendar/screens/calendar_screen.dart';
import '../features/insights/screens/insights_screen.dart';
import '../features/log/screens/log_screen.dart';
import '../features/onboarding/screens/biometric_setup_screen.dart';
import '../features/onboarding/screens/cycle_setup_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/onboarding/screens/pin_setup_screen.dart';
import '../features/settings/screens/export_screen.dart';
import '../features/settings/screens/privacy_policy_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/shared/widgets/ocean_background/ocean_background.dart';
import '../features/shared/widgets/cara_bottom_nav.dart';
import '../providers/auth_providers.dart';
import 'auth_guard.dart';
import 'route_names.dart';

// ---------------------------------------------------------------------------
// Route transition helper - 200ms fade per FLUTTER 4.1 acceptance criteria
// ---------------------------------------------------------------------------

CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeIn).animate(animation),
        child: child,
      );
    },
  );
}

// ---------------------------------------------------------------------------
// Shell scaffold - wraps tabs with CaraBottomNav
// ---------------------------------------------------------------------------

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return OceanBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navigationShell,
        bottomNavigationBar: CaraBottomNav(
          currentTab: CaraTab.values[navigationShell.currentIndex],
          onTabSelected: (tab) {
            navigationShell.goBranch(
              tab.index,
              initialLocation: tab.index == navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Router provider
// ---------------------------------------------------------------------------

/// Riverpod provider that owns the GoRouter singleton.
///
/// Watches [authStateProvider] so that any [AuthState] change automatically
/// triggers a GoRouter redirect evaluation.
final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = _AuthStateListenable(ref);

  final router = GoRouter(
    initialLocation: RouteNames.calendar,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      return authGuard(state: state, authState: authState);
    },
    routes: [
      // Onboarding flow (linear wizard, outside ShellRoute)
      GoRoute(
        path: RouteNames.onboarding,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const OnboardingScreen(),
        ),
        routes: [
          GoRoute(
            path: 'pin',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const PinSetupScreen(),
            ),
          ),
          GoRoute(
            path: 'biometric',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const BiometricSetupScreen(),
            ),
          ),
          GoRoute(
            path: 'cycle',
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const CycleSetupScreen(),
            ),
          ),
        ],
      ),

      // Lock screen (full-screen, outside ShellRoute)
      GoRoute(
        path: RouteNames.lock,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const LockScreen(),
        ),
      ),

      // StatefulShellRoute preserves navigator state per branch
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _ShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Calendar
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.calendar,
                pageBuilder: (context, state) => _fadePage(
                  state: state,
                  child: const CalendarScreen(),
                ),
              ),
            ],
          ),

          // Branch 1: Log
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.log,
                pageBuilder: (context, state) => _fadePage(
                  state: state,
                  child: const LogScreen(),
                ),
              ),
            ],
          ),

          // Branch 2: Insights
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.insights,
                pageBuilder: (context, state) => _fadePage(
                  state: state,
                  child: const InsightsScreen(),
                ),
              ),
            ],
          ),

          // Branch 3: Settings + sub-screens
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settings,
                pageBuilder: (context, state) => _fadePage(
                  state: state,
                  child: const SettingsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'export',
                    pageBuilder: (context, state) => _fadePage(
                      state: state,
                      child: const ExportScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'privacy',
                    pageBuilder: (context, state) => _fadePage(
                      state: state,
                      child: const PrivacyPolicyScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(() {
    authNotifier.dispose();
    router.dispose();
  });

  return router;
});

// ---------------------------------------------------------------------------
// Auth state listenable bridge
// ---------------------------------------------------------------------------

/// Bridges [authStateProvider] into a [ChangeNotifier] so that
/// [GoRouter.refreshListenable] can trigger redirect re-evaluation whenever
/// [AuthState] changes.
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    _subscription = ref.listen<AuthState>(
      authStateProvider,
      (previous, next) {
        if (previous != next) notifyListeners();
      },
    );
  }

  late final ProviderSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

