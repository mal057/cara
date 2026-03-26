import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/sola_dark_theme.dart';
import 'core/theme/sola_theme.dart';
import 'navigation/app_router.dart';
import 'providers/cycle_providers.dart';
import 'providers/notification_providers.dart';

/// Root application widget.
///
/// Uses MaterialApp.router with the GoRouter configured in [routerProvider].
/// Auth guard and bottom-nav shell are wired in the router; this widget only
/// owns theme and router configuration.
///
/// Also triggers notification rescheduling at app launch via a
/// [predictionProvider] listener. This handles the case where the OS cleared
/// scheduled notifications (e.g. device restart) so they are restored as soon
/// as the prediction data is available.
class SolaApp extends ConsumerWidget {
  const SolaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Reschedule notifications whenever the prediction resolves to data.
    // This covers:
    //   - App launch after device restart (OS clears pending notifications).
    //   - Any future case where predictionProvider is invalidated and reloads.
    ref.listen<AsyncValue<dynamic>>(predictionProvider, (previous, next) {
      if (next is AsyncData) {
        ref.read(notificationPrefsProvider.future).then((prefs) {
          final scheduler = ref.read(notificationSchedulerProvider);
          scheduler.rescheduleAll(next.value, prefs);
        });
      }
    });

    return MaterialApp.router(
      title: 'Sola',
      debugShowCheckedModeBanner: false,
      theme: solaLightTheme(),
      darkTheme: solaDarkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
