import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../shared/widgets/sola_scaffold.dart';
import '../widgets/cycle_calendar.dart';
import '../widgets/phase_badge.dart';

/// The Calendar tab screen - the home screen of Sola.
///
/// Layout (top to bottom):
/// 1. [CycleCalendar] - full-width TableCalendar with phase-coloured cells
/// 2. [PhaseBadge] - current phase name, day number, and wellness tip
///
/// Day selection opens [DayDetailSheet] (initiated inside [CycleCalendar]).
/// Month swipes pre-fetch adjacent months via [MonthDataCacheNotifier].
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SolaScaffold(
      // Full-bleed calendar - override default horizontal padding
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Calendar fills available width; no horizontal padding
          const CycleCalendar(),
          // Phase badge below calendar with standard page padding
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.pagePadding,
              vertical: AppSizes.space12,
            ),
            child: const PhaseBadge(),
          ),
        ],
      ),
    );
  }
}
