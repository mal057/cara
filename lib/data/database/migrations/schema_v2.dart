import 'package:drift/drift.dart';

import '../app_database.dart';

/// Migration from schema v1 to v2: adds emoji column to symptoms table
/// and introduces new mood symptoms with emoji representations.
class SchemaV2 {
  SchemaV2._();

  /// Runs the v1 -> v2 migration.
  static Future<void> migrate(Migrator m, AppDatabase db) async {
    // 1. Add nullable emoji column to symptoms table
    // Check if emoji column already exists (handles intermediate builds
    // where table definition included emoji but schema version was still 1).
    final columns = await db.customSelect(
      "PRAGMA table_info('symptoms')",
    ).get();
    final hasEmoji = columns.any((row) => row.read<String>('name') == 'emoji');
    if (!hasEmoji) {
      await m.addColumn(db.symptomsTable, db.symptomsTable.emoji);
    }

    // 2. Update existing mood symptoms with emoji values and fix icon names
    await db.transaction(() async {
      await db.customStatement(
        "UPDATE symptoms SET emoji = '\u{1F60A}', icon_name = 'sentiment_very_satisfied', display_order = 1 WHERE name = 'happy'",
      );
      await db.customStatement(
        "UPDATE symptoms SET emoji = '\u{1F622}', icon_name = 'sentiment_dissatisfied', display_order = 2 WHERE name = 'sad'",
      );
      await db.customStatement(
        "UPDATE symptoms SET emoji = '\u{1F630}', icon_name = 'warning_amber', display_order = 4 WHERE name = 'anxious'",
      );
      await db.customStatement(
        "UPDATE symptoms SET emoji = '\u{1F624}', icon_name = 'mood_bad', display_order = 5 WHERE name = 'irritable'",
      );
      await db.customStatement(
        "UPDATE symptoms SET emoji = '\u{1F3AD}', icon_name = 'swap_vert', display_order = 6 WHERE name = 'mood_swings'",
      );

      // 3. Insert new mood symptoms
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('depressed', 'mood', 'sentiment_very_dissatisfied', '\u{1F61E}', 3)",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('emotional', 'mood', 'water_drop', '\u{1F62D}', 7)",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('calm', 'mood', 'self_improvement', '\u{1F60C}', 8)",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('stressed', 'mood', 'psychology', '\u{1F62B}', 9)",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('sensitive', 'mood', 'favorite_border', '\u{1F97A}', 10)",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO symptoms (name, category, icon_name, emoji, display_order) VALUES ('confident', 'mood', 'fitness_center', '\u{1F4AA}', 11)",
      );

      // 4. Renumber non-mood symptoms starting at 12
      await db.customStatement(
        "UPDATE symptoms SET display_order = 12 WHERE name = 'cramps'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 13 WHERE name = 'headache'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 14 WHERE name = 'back_pain'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 15 WHERE name = 'breast_tenderness'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 16 WHERE name = 'joint_pain'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 17 WHERE name = 'fatigue'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 18 WHERE name = 'high_energy'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 19 WHERE name = 'acne'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 20 WHERE name = 'oily_skin'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 21 WHERE name = 'bloating'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 22 WHERE name = 'nausea'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 23 WHERE name = 'insomnia'",
      );
      await db.customStatement(
        "UPDATE symptoms SET display_order = 24 WHERE name = 'hypersomnia'",
      );
    });
  }
}
