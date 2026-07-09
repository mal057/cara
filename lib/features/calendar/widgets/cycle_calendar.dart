import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/extensions/date_extensions.dart';
import '../../../providers/calendar_providers.dart';
import 'day_cell.dart';

/// Wraps [TableCalendar] with Cara-specific custom builders and providers.
///
/// - [CalendarBuilders.defaultBuilder] renders [DayCell]
/// - [CalendarBuilders.selectedBuilder] renders selected [DayCell]
/// - [CalendarBuilders.todayBuilder] renders today [DayCell]
/// - [CalendarBuilders.outsideBuilder] renders outside-month [DayCell]
///
/// Month data is pre-fetched via [MonthDataCacheNotifier.loadMonth] on
/// [onPageChanged] so every [DayCell] build is an O(1) map lookup.
class CycleCalendar extends ConsumerWidget {
  const CycleCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final focusedMonth = ref.watch(focusedMonthProvider);

    return TableCalendar<Object>(
      focusedDay: focusedMonth,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      selectedDayPredicate: (day) => day.isSameDay(selectedDate),
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      availableGestures: AvailableGestures.horizontalSwipe,
      startingDayOfWeek: StartingDayOfWeek.monday,
      sixWeekMonthsEnforced: false,
      // Header styling
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: AppTypography.heading3,
        leftChevronIcon: const Icon(
          Icons.chevron_left_rounded,
          color: AppColors.textPrimary,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textPrimary,
        ),
      ),
      // Day-of-week row styling
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: AppTypography.overline.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
        weekendStyle: AppTypography.overline.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
      // Calendar styling
      calendarStyle: const CalendarStyle(
        cellMargin: EdgeInsets.all(2),
        outsideDaysVisible: true,
        defaultDecoration: BoxDecoration(),
        todayDecoration: BoxDecoration(),
        selectedDecoration: BoxDecoration(),
        outsideDecoration: BoxDecoration(),
        weekendDecoration: BoxDecoration(),
        markerDecoration: BoxDecoration(),
      ),
      // Custom day builders using cached DayDataModel
      calendarBuilders: CalendarBuilders<Object>(
        defaultBuilder: (ctx, day, focusedDay) => _buildCell(
          ref, day,
          isSelected: false,
          isToday: false,
          isOutsideMonth: false,
        ),
        selectedBuilder: (ctx, day, focusedDay) => _buildCell(
          ref, day,
          isSelected: true,
          isToday: false,
          isOutsideMonth: false,
        ),
        todayBuilder: (ctx, day, focusedDay) => _buildCell(
          ref, day,
          isSelected: day.isSameDay(selectedDate),
          isToday: true,
          isOutsideMonth: false,
        ),
        outsideBuilder: (ctx, day, focusedDay) => _buildCell(
          ref, day,
          isSelected: false,
          isToday: false,
          isOutsideMonth: true,
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        HapticFeedback.selectionClick();
        final normalized = DateTime(
          selectedDay.year, selectedDay.month, selectedDay.day);
        ref.read(selectedDateProvider.notifier).state = normalized;
        ref.read(focusedMonthProvider.notifier).state = focusedDay;
      },
      onPageChanged: (focusedDay) {
        ref.read(focusedMonthProvider.notifier).state = focusedDay;
        // Keep selected date in sync with the visible month so the PhaseBadge
        // always shows data from a cached month.
        final firstOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
        ref.read(selectedDateProvider.notifier).state = firstOfMonth;
        ref.read(monthDataCacheProvider.notifier).loadMonth(focusedDay);
      },
    );
  }

  Widget _buildCell(
    WidgetRef ref,
    DateTime day, {
    required bool isSelected,
    required bool isToday,
    required bool isOutsideMonth,
  }) {
    final normalized = DateTime(day.year, day.month, day.day);
    final dayData = ref.watch(dayDataProvider(normalized));
    return DayCell(
      day: day,
      dayData: dayData,
      isSelected: isSelected,
      isToday: isToday,
      isOutsideMonth: isOutsideMonth,
    );
  }
}
