import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Returns true if this date falls on the same calendar day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns a new DateTime at the very start of this day (00:00:00.000).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a new DateTime at the very end of this day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Returns the number of whole days until [other] (positive if [other] is in the future).
  int daysUntil(DateTime other) {
    final a = startOfDay;
    final b = other.startOfDay;
    return b.difference(a).inDays;
  }

  /// Returns the number of whole days since [other] (positive if [other] is in the past).
  int daysSince(DateTime other) {
    final a = startOfDay;
    final b = other.startOfDay;
    return a.difference(b).inDays;
  }

  /// Returns true if this date is today.
  bool get isToday => isSameDay(DateTime.now());

  /// Returns true if this date falls before today (ignoring time).
  bool get isBeforeToday {
    final today = DateTime.now().startOfDay;
    return startOfDay.isBefore(today);
  }

  /// Returns true if this date falls after today (ignoring time).
  bool get isAfterToday {
    final today = DateTime.now().startOfDay;
    return startOfDay.isAfter(today);
  }

  /// Returns a human-readable display format: "Feb 22, 2026".
  String get formatted => DateFormat('MMM d, y').format(this);

  /// Returns a short display format: "Feb 22".
  String get shortFormatted => DateFormat('MMM d').format(this);

  /// Returns the month and year: "February 2026".
  String get monthYear => DateFormat('MMMM y').format(this);

  /// Returns a YYYY-MM key suitable for use as a cache map key.
  /// Example: 2026-02
  String get monthKey => DateFormat('yyyy-MM').format(this);

  /// Returns the cycle day number given the [cycleStart] date.
  /// Day 1 is the first day of the cycle (the start date itself).
  /// Returns 1 if this date is before [cycleStart].
  int cycleDayFrom(DateTime cycleStart) {
    final diff = startOfDay.difference(cycleStart.startOfDay).inDays;
    return diff < 0 ? 1 : diff + 1;
  }
}
