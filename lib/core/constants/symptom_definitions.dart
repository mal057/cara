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

  /// Sort order within the symptom grid (lower = earlier).
  final int displayOrder;
}

/// Canonical list of all trackable symptoms in display order.
///
/// The [SymptomDefinition.id] values are stable identifiers that are stored
/// in the database — do NOT change them after release.
const List<SymptomDefinition> kSymptomDefinitions = [
  SymptomDefinition(
    id: 'mood',
    name: 'Mood',
    category: SymptomCategory.mood,
    icon: Icons.sentiment_satisfied_alt_outlined,
    displayOrder: 1,
  ),
  SymptomDefinition(
    id: 'cramps',
    name: 'Cramps',
    category: SymptomCategory.pain,
    icon: Icons.electric_bolt_outlined,
    displayOrder: 2,
  ),
  SymptomDefinition(
    id: 'headache',
    name: 'Headache',
    category: SymptomCategory.pain,
    icon: Icons.psychology_outlined,
    displayOrder: 3,
  ),
  SymptomDefinition(
    id: 'energy',
    name: 'Energy',
    category: SymptomCategory.energy,
    icon: Icons.flash_on_outlined,
    displayOrder: 4,
  ),
  SymptomDefinition(
    id: 'bloating',
    name: 'Bloating',
    category: SymptomCategory.digestion,
    icon: Icons.bubble_chart_outlined,
    displayOrder: 5,
  ),
  SymptomDefinition(
    id: 'digestion',
    name: 'Digestion',
    category: SymptomCategory.digestion,
    icon: Icons.restaurant_outlined,
    displayOrder: 6,
  ),
  SymptomDefinition(
    id: 'sleep',
    name: 'Sleep',
    category: SymptomCategory.sleep,
    icon: Icons.bedtime_outlined,
    displayOrder: 7,
  ),
  SymptomDefinition(
    id: 'breast_tenderness',
    name: 'Breast Tenderness',
    category: SymptomCategory.pain,
    icon: Icons.favorite_border_outlined,
    displayOrder: 8,
  ),
  SymptomDefinition(
    id: 'acne',
    name: 'Acne',
    category: SymptomCategory.skin,
    icon: Icons.face_outlined,
    displayOrder: 9,
  ),
  SymptomDefinition(
    id: 'skin',
    name: 'Skin Changes',
    category: SymptomCategory.skin,
    icon: Icons.spa_outlined,
    displayOrder: 10,
  ),
  SymptomDefinition(
    id: 'cravings',
    name: 'Cravings',
    category: SymptomCategory.other,
    icon: Icons.cake_outlined,
    displayOrder: 11,
  ),
  SymptomDefinition(
    id: 'discharge',
    name: 'Discharge',
    category: SymptomCategory.other,
    icon: Icons.water_drop_outlined,
    displayOrder: 12,
  ),
  SymptomDefinition(
    id: 'libido',
    name: 'Libido',
    category: SymptomCategory.other,
    icon: Icons.favorite_outlined,
    displayOrder: 13,
  ),
  SymptomDefinition(
    id: 'exercise',
    name: 'Exercise',
    category: SymptomCategory.energy,
    icon: Icons.directions_run_outlined,
    displayOrder: 14,
  ),
  SymptomDefinition(
    id: 'anxiety',
    name: 'Anxiety',
    category: SymptomCategory.mood,
    icon: Icons.self_improvement_outlined,
    displayOrder: 15,
  ),
  SymptomDefinition(
    id: 'back_pain',
    name: 'Back Pain',
    category: SymptomCategory.pain,
    icon: Icons.accessibility_new_outlined,
    displayOrder: 16,
  ),
];
