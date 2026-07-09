enum ExportRange {
  threeMonths,
  sixMonths,
  oneYear,
  allTime;

  String get displayName {
    switch (this) {
      case ExportRange.threeMonths:
        return 'Last 3 Months';
      case ExportRange.sixMonths:
        return 'Last 6 Months';
      case ExportRange.oneYear:
        return 'Last Year';
      case ExportRange.allTime:
        return 'All Time';
    }
  }

  /// Returns the number of months to look back, or null for all time.
  int? get months {
    switch (this) {
      case ExportRange.threeMonths:
        return 3;
      case ExportRange.sixMonths:
        return 6;
      case ExportRange.oneYear:
        return 12;
      case ExportRange.allTime:
        return null;
    }
  }

  /// Returns the start DateTime for this range relative to [now].
  DateTime? startDate(DateTime now) {
    final m = months;
    if (m == null) return null;
    return DateTime(now.year, now.month - m, now.day);
  }
}
