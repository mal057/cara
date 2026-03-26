enum SymptomCategory {
  mood,
  pain,
  energy,
  skin,
  digestion,
  sleep,
  other;

  String get displayName {
    switch (this) {
      case SymptomCategory.mood:
        return 'Mood';
      case SymptomCategory.pain:
        return 'Pain';
      case SymptomCategory.energy:
        return 'Energy';
      case SymptomCategory.skin:
        return 'Skin';
      case SymptomCategory.digestion:
        return 'Digestion';
      case SymptomCategory.sleep:
        return 'Sleep';
      case SymptomCategory.other:
        return 'Other';
    }
  }

  static SymptomCategory fromString(String value) {
    switch (value) {
      case 'mood':
        return SymptomCategory.mood;
      case 'pain':
        return SymptomCategory.pain;
      case 'energy':
        return SymptomCategory.energy;
      case 'skin':
        return SymptomCategory.skin;
      case 'digestion':
        return SymptomCategory.digestion;
      case 'sleep':
        return SymptomCategory.sleep;
      case 'other':
        return SymptomCategory.other;
      default:
        throw ArgumentError('Invalid SymptomCategory value: $value');
    }
  }
}
