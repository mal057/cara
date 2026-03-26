enum SymptomSeverity {
  mild,
  moderate,
  severe;

  String get displayName {
    switch (this) {
      case SymptomSeverity.mild:
        return 'Mild';
      case SymptomSeverity.moderate:
        return 'Moderate';
      case SymptomSeverity.severe:
        return 'Severe';
    }
  }

  /// Integer value for database storage (1-3).
  int get value {
    switch (this) {
      case SymptomSeverity.mild:
        return 1;
      case SymptomSeverity.moderate:
        return 2;
      case SymptomSeverity.severe:
        return 3;
    }
  }

  static SymptomSeverity fromValue(int value) {
    switch (value) {
      case 1:
        return SymptomSeverity.mild;
      case 2:
        return SymptomSeverity.moderate;
      case 3:
        return SymptomSeverity.severe;
      default:
        throw ArgumentError('Invalid SymptomSeverity value: $value');
    }
  }
}
