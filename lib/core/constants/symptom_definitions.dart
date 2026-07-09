import 'package:flutter/material.dart';

import '../enums/symptom_category.dart';

/// Immutable data class describing a single trackable symptom.
@immutable
class SymptomDefinition {
  const SymptomDefinition({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    this.emoji,
    required this.displayOrder,
  });

  /// Stable identifier stored in the database.
  final String id;

  /// Human-readable label shown in the UI.
  final String name;

  /// Category grouping for filtering and statistics.
  final SymptomCategory category;

  /// Material icon representing this symptom.
  final IconData icon;

  /// Optional emoji string for mood symptoms. When non-null, UI renders the
  /// emoji instead of [icon].
  final String? emoji;

  /// Sort order within the symptom grid (lower = earlier).
  final int displayOrder;

  /// Whether this definition has an emoji representation.
  bool get hasEmoji => emoji != null;
}

/// Canonical list of all trackable symptoms in display order.
///
/// The [SymptomDefinition.id] values are stable identifiers that are stored
/// in the database — do NOT change them after release.
const List<SymptomDefinition> kSymptomDefinitions = [
  // mood (11) — emoji-backed mood symptoms
  SymptomDefinition(
    id: 'happy',
    name: 'Happy',
    category: SymptomCategory.mood,
    icon: Icons.sentiment_very_satisfied_outlined,
    emoji: '\u{1F60A}',
    displayOrder: 1,
  ),
  SymptomDefinition(
    id: 'sad',
    name: 'Sad',
    category: SymptomCategory.mood,
    icon: Icons.sentiment_dissatisfied_outlined,
    emoji: '\u{1F622}',
    displayOrder: 2,
  ),
  SymptomDefinition(
    id: 'depressed',
    name: 'Depressed',
    category: SymptomCategory.mood,
    icon: Icons.sentiment_very_dissatisfied_outlined,
    emoji: '\u{1F61E}',
    displayOrder: 3,
  ),
  SymptomDefinition(
    id: 'irritable',
    name: 'Irritable',
    category: SymptomCategory.mood,
    icon: Icons.mood_bad_outlined,
    emoji: '\u{1F624}',
    displayOrder: 4,
  ),
  SymptomDefinition(
    id: 'mood_swings',
    name: 'Mood Swings',
    category: SymptomCategory.mood,
    icon: Icons.swap_vert_outlined,
    emoji: '\u{1F3AD}',
    displayOrder: 5,
  ),
  SymptomDefinition(
    id: 'emotional',
    name: 'Emotional',
    category: SymptomCategory.mood,
    icon: Icons.water_drop_outlined,
    emoji: '\u{1F62D}',
    displayOrder: 6,
  ),
  SymptomDefinition(
    id: 'calm',
    name: 'Calm',
    category: SymptomCategory.mood,
    icon: Icons.self_improvement_outlined,
    emoji: '\u{1F60C}',
    displayOrder: 7,
  ),
  SymptomDefinition(
    id: 'stressed',
    name: 'Stressed',
    category: SymptomCategory.mood,
    icon: Icons.psychology_outlined,
    emoji: '\u{1F62B}',
    displayOrder: 8,
  ),
  SymptomDefinition(
    id: 'sensitive',
    name: 'Sensitive',
    category: SymptomCategory.mood,
    icon: Icons.favorite_border_outlined,
    emoji: '\u{1F97A}',
    displayOrder: 9,
  ),
  SymptomDefinition(
    id: 'confident',
    name: 'Confident',
    category: SymptomCategory.mood,
    icon: Icons.fitness_center_outlined,
    emoji: '\u{1F4AA}',
    displayOrder: 10,
  ),
  SymptomDefinition(
    id: 'anxious',
    name: 'Anxiety',
    category: SymptomCategory.mood,
    icon: Icons.warning_amber_outlined,
    emoji: '\u{1F630}',
    displayOrder: 11,
  ),
  // Non-mood symptoms (no emoji)
  SymptomDefinition(
    id: 'cramps',
    name: 'Cramps',
    category: SymptomCategory.pain,
    icon: Icons.electric_bolt_outlined,
    displayOrder: 12,
  ),
  SymptomDefinition(
    id: 'headache',
    name: 'Headache',
    category: SymptomCategory.pain,
    icon: Icons.psychology_outlined,
    displayOrder: 13,
  ),
  SymptomDefinition(
    id: 'energy',
    name: 'Energy',
    category: SymptomCategory.energy,
    icon: Icons.flash_on_outlined,
    displayOrder: 14,
  ),
  SymptomDefinition(
    id: 'bloating',
    name: 'Bloating',
    category: SymptomCategory.digestion,
    icon: Icons.bubble_chart_outlined,
    displayOrder: 15,
  ),
  SymptomDefinition(
    id: 'digestion',
    name: 'Digestion',
    category: SymptomCategory.digestion,
    icon: Icons.restaurant_outlined,
    displayOrder: 16,
  ),
  SymptomDefinition(
    id: 'sleep',
    name: 'Sleep',
    category: SymptomCategory.sleep,
    icon: Icons.bedtime_outlined,
    displayOrder: 17,
  ),
  SymptomDefinition(
    id: 'breast_tenderness',
    name: 'Breast Tenderness',
    category: SymptomCategory.pain,
    icon: Icons.favorite_border_outlined,
    displayOrder: 18,
  ),
  SymptomDefinition(
    id: 'acne',
    name: 'Acne',
    category: SymptomCategory.skin,
    icon: Icons.face_outlined,
    displayOrder: 19,
  ),
  SymptomDefinition(
    id: 'skin',
    name: 'Skin Changes',
    category: SymptomCategory.skin,
    icon: Icons.spa_outlined,
    displayOrder: 20,
  ),
  SymptomDefinition(
    id: 'cravings',
    name: 'Cravings',
    category: SymptomCategory.other,
    icon: Icons.cake_outlined,
    displayOrder: 21,
  ),
  SymptomDefinition(
    id: 'discharge',
    name: 'Discharge',
    category: SymptomCategory.other,
    icon: Icons.water_drop_outlined,
    displayOrder: 22,
  ),
  SymptomDefinition(
    id: 'libido',
    name: 'Libido',
    category: SymptomCategory.other,
    icon: Icons.favorite_outlined,
    displayOrder: 23,
  ),
  SymptomDefinition(
    id: 'exercise',
    name: 'Exercise',
    category: SymptomCategory.energy,
    icon: Icons.directions_run_outlined,
    displayOrder: 24,
  ),
  SymptomDefinition(
    id: 'back_pain',
    name: 'Back Pain',
    category: SymptomCategory.pain,
    icon: Icons.accessibility_new_outlined,
    displayOrder: 25,
  ),
];
