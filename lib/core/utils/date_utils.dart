import 'package:intl/intl.dart';

import '../extensions/date_extensions.dart';

/// Utility functions for date ranges and formatting used throughout Sola.
class SolaDateUtils {
  SolaDateUtils._();

  // ---------------------------------------------------------------------------
  // Date range helpers
  // ---------------------------------------------------------------------------

  /// Returns a list of every [DateTime] from [start] to [end] inclusive.
  /// Both bounds are normalised to start-of-day.
  static List<DateTime> dateRange(DateTime start, DateTime end) {
    final from = start.startOfDay;
    final to = end.startOfDay;
    if (to.isBefore(from)) return [];
    final days = to.difference(from).inDays + 1;
    return List.generate(days, (i) => DateTime(from.year, from.month, from.day + i));
  }

  /// Returns the first [DateTime] of the month that contains [date].
  static DateTime firstDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  /// Returns the last [DateTime] of the month that contains [date].
  static DateTime lastDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);

  /// Returns true if [date] falls within [start]..[end] inclusive.
  /// All values are compared at day granularity.
  static bool isInRange(DateTime date, DateTime start, DateTime end) {
    final d = date.startOfDay;
    return !d.isBefore(start.startOfDay) && !d.isAfter(end.startOfDay);
  }

  /// Returns the number of whole days between [start] and [end].
  /// Always non-negative; order of arguments does not matter.
  static int daysBetween(DateTime start, DateTime end) {
    return start.startOfDay.difference(end.startOfDay).inDays.abs();
  }

  // ---------------------------------------------------------------------------
  // Formatting helpers
  // ---------------------------------------------------------------------------

  /// Formats [date] as "February 2026".
  static String formatMonthYear(DateTime date) =>
      DateFormat('MMMM y').format(date);

  /// Formats [date] as "Feb 22, 2026".
  static String formatFull(DateTime date) =>
      DateFormat('MMM d, y').format(date);

  /// Formats [date] as "Feb 22".
  static String formatShort(DateTime date) =>
      DateFormat('MMM d').format(date);

  /// Formats [date] as "22 Feb – 14 Mar" style range string.
  static String formatRange(DateTime start, DateTime end) {
    final s = DateFormat('d MMM').format(start);
    final e = DateFormat('d MMM').format(end);
    return '$s – $e';
  }

  /// Returns a YYYY-MM-DD string for use in SQL queries or storage keys.
  static String toIso8601Date(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  /// Parses a YYYY-MM-DD string and returns a [DateTime] at start-of-day.
  /// Throws [FormatException] if [value] is not a valid date.
  static DateTime fromIso8601Date(String value) {
    final parsed = DateFormat('yyyy-MM-dd').parseStrict(value);
    return parsed.startOfDay;
  }
}
