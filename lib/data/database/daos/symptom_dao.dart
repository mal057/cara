import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/symptom_entries_table.dart';
import '../tables/symptoms_table.dart';
import '../../models/symptom_entry_model.dart';
import '../../models/symptom_model.dart';
import '../../models/symptom_stat_model.dart';
import '../../../core/enums/symptom_category.dart';
import '../../../core/enums/symptom_severity.dart';

part 'symptom_dao.g.dart';

/// Data access object for symptoms (reference) and symptom_entries (logs).
///
/// [getAllSymptoms] caches the small static reference table in memory so
/// subsequent calls are free (per ned-flutter.md §3.4 — cached reference data).
///
/// [insertEntries] wraps batch inserts in a transaction to avoid per-row
/// SQLCipher encryption overhead (Karla Note 1).
///
/// [getAggregatedStats] uses a raw SQL GROUP BY query so the app never loads
/// all symptom_entries into memory (Karla Note 3).
@DriftAccessor(tables: [SymptomsTable, SymptomEntriesTable])
class SymptomDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomDaoMixin {
  SymptomDao(super.db);

  /// In-memory cache for the static symptoms reference table.
  /// Set on first [getAllSymptoms] call; cleared only if the DAO is re-created.
  List<SymptomModel>? _symptomCache;

  // ---------------------------------------------------------------------------
  // Reference table
  // ---------------------------------------------------------------------------

  /// Returns all symptom definitions ordered by display_order.
  ///
  /// Results are cached in [_symptomCache] after the first database read. The
  /// symptoms table is a static seed table (18 rows) that never changes after
  /// first launch, so an in-process cache is safe and avoids repeated SQLCipher
  /// round-trips.
  Future<List<SymptomModel>> getAllSymptoms() async {
    if (_symptomCache != null) return _symptomCache!;

    final rows = await (select(symptomsTable)
          ..orderBy([(t) => OrderingTerm.asc(t.displayOrder)]))
        .get();

    _symptomCache = rows.map(_symptomRowToModel).toList();
    return _symptomCache!;
  }

  // ---------------------------------------------------------------------------
  // Entry queries
  // ---------------------------------------------------------------------------

  /// Returns all symptom entries for [date], each enriched with its resolved
  /// [SymptomModel] via a JOIN on the symptoms table.
  ///
  /// Uses the composite index idx_symptom_entries_date_symptom_id (Karla Note 1).
  Future<List<SymptomEntryModel>> getEntriesForDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);

    final query = select(symptomEntriesTable).join([
      innerJoin(
        symptomsTable,
        symptomsTable.id.equalsExp(symptomEntriesTable.symptomId),
      ),
    ])
      ..where(symptomEntriesTable.date.equals(dateStr));

    final rows = await query.get();
    return rows.map((row) {
      final entry = row.readTable(symptomEntriesTable);
      final symptom = row.readTable(symptomsTable);
      return _entryRowToModel(entry, symptomRow: symptom);
    }).toList();
  }

  /// Batch-inserts all [entries] inside a single transaction.
  ///
  /// Wrapping in a transaction means SQLCipher encrypts and flushes once for
  /// the entire batch rather than once per row — critical when a user logs
  /// 5–8 symptoms at once (Karla Note 1).
  Future<void> insertEntries(
    List<SymptomEntriesTableCompanion> entries,
  ) async {
    if (entries.isEmpty) return;
    await transaction(() async {
      await batch((b) {
        for (final entry in entries) {
          b.insert(symptomEntriesTable, entry);
        }
      });
    });
  }

  /// Deletes all symptom entries logged on [date].
  Future<void> deleteEntriesForDate(DateTime date) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    await (delete(symptomEntriesTable)
          ..where((t) => t.date.equals(dateStr)))
        .go();
  }

  /// Returns aggregated symptom statistics for the date range [[start], [end]].
  ///
  /// Executes a single SQL GROUP BY query — no full table load. Returns one
  /// [SymptomStat] per distinct symptom_id, ordered by occurrence count
  /// descending so the most-frequent symptoms appear first (Karla Note 3).
  Future<List<SymptomStat>> getAggregatedStats(
    DateTime start,
    DateTime end,
  ) async {
    final startStr = start.toIso8601String().substring(0, 10);
    final endStr = end.toIso8601String().substring(0, 10);

    const sql = '''
      SELECT
        se.symptom_id         AS symptom_id,
        s.name                AS symptom_name,
        s.category            AS category,
        s.icon_name           AS icon_name,
        COUNT(*)              AS occurrence_count,
        AVG(se.severity)      AS avg_severity
      FROM symptom_entries se
      INNER JOIN symptoms s ON se.symptom_id = s.id
      WHERE se.date >= ? AND se.date <= ?
      GROUP BY se.symptom_id
      ORDER BY occurrence_count DESC
    ''';

    final results = await customSelect(
      sql,
      variables: [
        Variable.withString(startStr),
        Variable.withString(endStr),
      ],
      readsFrom: {symptomEntriesTable, symptomsTable},
    ).get();

    return results.map((row) {
      return SymptomStat(
        symptomId: row.read<int>('symptom_id'),
        symptomName: row.read<String>('symptom_name'),
        category: SymptomCategory.fromString(row.read<String>('category')),
        iconName: row.read<String>('icon_name'),
        occurrenceCount: row.read<int>('occurrence_count'),
        averageSeverity: row.read<double>('avg_severity'),
      );
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Mappers
  // ---------------------------------------------------------------------------

  SymptomModel _symptomRowToModel(SymptomsTableData row) {
    return SymptomModel(
      id: row.id,
      name: row.name,
      category: SymptomCategory.fromString(row.category),
      iconName: row.iconName,
      displayOrder: row.displayOrder,
    );
  }

  SymptomEntryModel _entryRowToModel(
    SymptomEntriesTableData entry, {
    required SymptomsTableData symptomRow,
  }) {
    return SymptomEntryModel(
      id: entry.id,
      date: DateTime.parse(entry.date),
      symptomId: entry.symptomId,
      symptom: _symptomRowToModel(symptomRow),
      severity: SymptomSeverity.fromValue(entry.severity),
      createdAt: DateTime.parse(entry.createdAt),
    );
  }
}
