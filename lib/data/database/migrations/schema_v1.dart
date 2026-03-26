import 'package:drift/drift.dart';

import '../app_database.dart';

/// Initial schema creation and seed data for Sola v1.
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
  // Symptoms reference table — 18 rows (>= 15 required by acceptance criteria)
  // ---------------------------------------------------------------------------

  static Future<void> _seedSymptoms(AppDatabase db) async {
    // SymptomsTable has no timestamp columns — only id, name, category,
    // icon_name, display_order. No `now` timestamp needed here.
    const symptoms = [
      // mood (5)
      _SymptomSeed('happy',             'mood',       'sentiment_very_satisfied', 1),
      _SymptomSeed('sad',               'mood',       'sentiment_dissatisfied',   2),
      _SymptomSeed('anxious',           'mood',       'psychology',               3),
      _SymptomSeed('irritable',         'mood',       'mood_bad',                 4),
      _SymptomSeed('mood_swings',       'mood',       'swap_vert',                5),
      // pain (5)
      _SymptomSeed('cramps',            'pain',       'medical_services',         6),
      _SymptomSeed('headache',          'pain',       'sick',                     7),
      _SymptomSeed('back_pain',         'pain',       'accessibility_new',        8),
      _SymptomSeed('breast_tenderness', 'pain',       'favorite_border',          9),
      _SymptomSeed('joint_pain',        'pain',       'sports_martial_arts',     10),
      // energy (2)
      _SymptomSeed('fatigue',           'energy',     'battery_low',             11),
      _SymptomSeed('high_energy',       'energy',     'bolt',                    12),
      // skin (2)
      _SymptomSeed('acne',              'skin',       'face_retouching_natural',  13),
      _SymptomSeed('oily_skin',         'skin',       'water_drop',              14),
      // digestion (2)
      _SymptomSeed('bloating',          'digestion',  'bubble_chart',            15),
      _SymptomSeed('nausea',            'digestion',  'local_hospital',          16),
      // sleep (2)
      _SymptomSeed('insomnia',          'sleep',      'nights_stay',             17),
      _SymptomSeed('hypersomnia',       'sleep',      'bed',                     18),
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
      // period_approaching: 2 days before, disabled by default
      batch.insert(
        db.notificationPreferencesTable,
        NotificationPreferencesTableCompanion.insert(
          type: 'period_approaching',
          enabled: const Value(0),
          daysBefore: const Value(2),
          timeOfDay: const Value(null),
          updatedAt: now,
        ),
      );

      // fertile_window: 0 days before (same day), disabled by default
      batch.insert(
        db.notificationPreferencesTable,
        NotificationPreferencesTableCompanion.insert(
          type: 'fertile_window',
          enabled: const Value(0),
          daysBefore: const Value(0),
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
    this.displayOrder,
  );

  final String name;
  final String category;
  final String iconName;
  final int displayOrder;
}
