import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// The four main navigation destinations of the Sola app.
enum SolaTab {
  calendar,
  log,
  insights,
  settings,
}

/// Persistent bottom navigation bar with four tabs:
/// Calendar, Log, Insights, Settings.
///
/// Uses Material 3 [NavigationBar] for proper indicator, label, and
/// accessibility semantics. The active tab is highlighted with
/// [AppColors.primary]; inactive items use [AppColors.textSecondary].
///
/// Emits [onTabSelected] with the tapped [SolaTab]; the caller is
/// responsible for updating [currentTab] (typically via a [StateProvider]).
///
/// Example:
/// ```dart
/// SolaBottomNav(
///   currentTab: SolaTab.calendar,
///   onTabSelected: (tab) => ref.read(activeTabProvider.notifier).state = tab,
/// )
/// ```
class SolaBottomNav extends StatelessWidget {
  const SolaBottomNav({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  /// The currently active tab.
  final SolaTab currentTab;

  /// Called when the user taps a tab.
  final ValueChanged<SolaTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentTab.index,
      onDestinationSelected: (index) {
        // Light haptic feedback on every tab tap.
        HapticFeedback.selectionClick();
        onTabSelected(SolaTab.values[index]);
      },
      // Enforce the design-system height.
      height: AppSizes.bottomNavHeight,
      backgroundColor: AppColors.surface,
      // Subtle primary-tinted indicator behind the selected icon.
      indicatorColor: AppColors.primary.withAlpha(26),
      elevation: AppSizes.elevationSheet,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          selectedIcon: Icon(Icons.calendar_month),
          label: 'Calendar',
          tooltip: 'Calendar — view your cycle',
        ),
        NavigationDestination(
          icon: Icon(Icons.edit_outlined),
          selectedIcon: Icon(Icons.edit),
          label: 'Log',
          tooltip: 'Log — record today\'s data',
        ),
        NavigationDestination(
          icon: Icon(Icons.insights_outlined),
          selectedIcon: Icon(Icons.insights),
          label: 'Insights',
          tooltip: 'Insights — cycle statistics',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
          tooltip: 'Settings — preferences and security',
        ),
      ],
    );
  }
}
