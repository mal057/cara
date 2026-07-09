import 'package:drift/drift.dart';

import '../app_database.dart';

/// Initial schema creation and seed data for Cara v1.
///
/// Called by [AppDatabase.migration] inside the [MigrationStrategy.onCreate]
/// callback. All seed inserts are wrapped in a single transaction so that
/// SQLCipher's encryption overhead is paid once (per Karla Note 1).
class SchemaV1 {
  SchemaV1._();

  /// Runs [m.createAll()] to materialise all tables and indexes defined via
  /// Drift annotations, then seeds the three reference tables.
  ///
  /// Parameters:
  ///   [m]  – the [Migrator] provided by Drift's migration callback.
  ///   [db] – the [AppDatabase] instance (needed to access table companions).
  static Future<void> migrate(Migrator m, AppDatabase db) async {
    // Create all tables and their indexes in one DDL pass.
    await m.createAll();

    // Seed reference data inside a single transaction to avoid per-row
    // SQLCipher encryption overhead (Karla Note 1: batch transactions).
    await db.transaction(() async {
      await _seedSymptoms(db);
      await _seedSettings(db);
      await _seedNotificationPreferences(db);
    });
  }

  // ---------------------------------------------------------------------------
  // Symptoms reference table — 24 rows (>= 15 required by acceptance criteria)
  // ---------------------------------------------------------------------------

  static Future<void> _seedSymptoms(AppDatabase db) async {
    // SymptomsTable has columns: id, name, category, icon_name, emoji,
    // display_order. No `now` timestamp needed here.
    const symptoms = [
      // mood (11) — with emoji
      _SymptomSeed('happy',             'mood',       'sentiment_very_satisfied',      1, '\u{1F60A}'),
      _SymptomSeed('sad',               'mood',       'sentiment_dissatisfied',        2, '\u{1F622}'),
      _SymptomSeed('depressed',         'mood',       'sentiment_very_dissatisfied',   3, '\u{1F61E}'),
      _SymptomSeed('anxious',           'mood',       'warning_amber',                 4, '\u{1F630}'),
      _SymptomSeed('irritable',         'mood',       'mood_bad',                      5, '\u{1F624}'),
      _SymptomSeed('mood_swings',       'mood',       'swap_vert',                     6, '\u{1F3AD}'),
      _SymptomSeed('emotional',         'mood',       'water_drop',                    7, '\u{1F62D}'),
      _SymptomSeed('calm',              'mood',       'self_improvement',              8, '\u{1F60C}'),
      _SymptomSeed('stressed',          'mood',       'psychology',                    9, '\u{1F62B}'),
      _SymptomSeed('sensitive',         'mood',       'favorite_border',              10, '\u{1F97A}'),
      _SymptomSeed('confident',         'mood',       'fitness_center',               11, '\u{1F4AA}'),
      // pain (5) — starting at 12
      _SymptomSeed('cramps',            'pain',       'medical_services',             12),
      _SymptomSeed('headache',          'pain',       'sick',                         13),
      _SymptomSeed('back_pain',         'pain',       'accessibility_new',            14),
      _SymptomSeed('breast_tenderness', 'pain',       'favorite_border',              15),
      _SymptomSeed('joint_pain',        'pain',       'sports_martial_arts',          16),
      // energy (2) — 17-18
      _SymptomSeed('fatigue',           'energy',     'battery_low',                  17),
      _SymptomSeed('high_energy',       'energy',     'bolt',                         18),
      // skin (2) — 19-20
      _SymptomSeed('acne',              'skin',       'face_retouching_natural',      19),
      _SymptomSeed('oily_skin',         'skin',       'water_drop',                   20),
      // digestion (2) — 21-22
      _SymptomSeed('bloating',          'digestion',  'bubble_chart',                 21),
      _SymptomSeed('nausea',            'digestion',  'local_hospital',               22),
      // sleep (2) — 23-24
      _SymptomSeed('insomnia',          'sleep',      'nights_stay',                  23),
      _SymptomSeed('hypersomnia',       'sleep',      'bed',                          24),
    ];

    await db.batch((batch) {
      for (final s in symptoms) {
        batch.insert(
          db.symptomsTable,
          SymptomsTableCompanion.insert(
            name: s.name,
            category: s.category,
            iconName: s.iconName,
            displayOrder: s.displayOrder,
            emoji: Value(s.emoji),
          ),
        );
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Settings defaults
  // ---------------------------------------------------------------------------

  static Future<void> _seedSettings(AppDatabase db) async {
    final now = DateTime.now().toIso8601String();

    await db.batch((batch) {
      for (final entry in _defaultSettings.entries) {
        batch.insert(
          db.settingsTable,
          SettingsTableCompanion.insert(
            key: entry.key,
            value: entry.value,
            updatedAt: now,
          ),
        );
      }
    });
  }

  static const Map<String, String> _defaultSettings = {
    'default_cycle_length': '28',
    'default_period_length': '5',
    'auto_lock_timeout_seconds': '30',
    'onboarding_complete': 'false',
  };

  // ---------------------------------------------------------------------------
  // Notification preference defaults
  // ---------------------------------------------------------------------------

  static Future<void> _seedNotificationPreferences(AppDatabase db) async {
    final now = DateTime.now().toIso8601String();

    await db.batch((batch) {
      // period_approaching: 2 days before, enabled by default
      batch.insert(
        db.notificationPreferencesTable,
        NotificationPreferencesTableCompanion.insert(
          type: 'period_approaching',
          enabled: const Value(1),
          daysBefore: const Value(2),
          timeOfDay: const Value(null),
          updatedAt: now,
        ),
      );

      // fertile_window: 2 days before, enabled by default
      batch.insert(
        db.notificationPreferencesTable,
        NotificationPreferencesTableCompanion.insert(
          type: 'fertile_window',
          enabled: const Value(1),
          daysBefore: const Value(2),
          timeOfDay: const Value(null),
          updatedAt: now,
        ),
      );

      // daily_reminder: 21:00, disabled by default
      batch.insert(
        db.notificationPreferencesTable,
        NotificationPreferencesTableCompanion.insert(
          type: 'daily_reminder',
          enabled: const Value(0),
          daysBefore: const Value(null),
          timeOfDay: const Value('21:00'),
          updatedAt: now,
        ),
      );
    });
  }
}

/// Lightweight immutable value object used only during symptom seeding.
class _SymptomSeed {
  const _SymptomSeed(
    this.name,
    this.category,
    this.iconName,
    this.displayOrder, [
    this.emoji,
  ]);

  final String name;
  final String category;
  final String iconName;
  final int displayOrder;
  final String? emoji;
}
