import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/symptom_entry_model.dart';
import '../data/models/symptom_model.dart';
import '../data/models/symptom_stat_model.dart';
import '../core/enums/export_range.dart';
import 'database_provider.dart';

/// Provides the full list of symptom reference data (static seed table).
///
/// Cached in-memory by [SymptomDao.getAllSymptoms] after the first read so
/// subsequent calls are free (small static table, Karla Note 3).
final symptomListProvider = FutureProvider<List<SymptomModel>>((ref) async {
  final dao = ref.watch(symptomDaoProvider);
  return dao.getAllSymptoms();
});

/// Provides symptom entries for a given [date].
///
/// Uses [FutureProvider.family] so each date gets its own cached async value.
/// Re-fetch by invalidating this provider after writes.
final daySymptomEntriesProvider =
    FutureProvider.family<List<SymptomEntryModel>, DateTime>((ref, date) async {
  final dao = ref.watch(symptomDaoProvider);
  return dao.getEntriesForDate(date);
});

/// Provides aggregated symptom statistics for a given [ExportRange].
///
/// Uses SQL GROUP BY via [SymptomDao.getAggregatedStats] so no full table
/// is loaded into memory (Karla Note 3). Keyed by [ExportRange] enum value.
final symptomStatsProvider =
    FutureProvider.family<List<SymptomStat>, ExportRange>((ref, range) async {
  final dao = ref.watch(symptomDaoProvider);
  final now = DateTime.now();
  final end = DateTime(now.year, now.month, now.day);
  final start = range.startDate(now) ?? DateTime(2000);
  return dao.getAggregatedStats(start, end);
});
