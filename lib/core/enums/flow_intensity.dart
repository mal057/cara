enum FlowIntensity {
  light,
  medium,
  heavy;

  String get displayName {
    switch (this) {
      case FlowIntensity.light:
        return 'Light';
      case FlowIntensity.medium:
        return 'Medium';
      case FlowIntensity.heavy:
        return 'Heavy';
    }
  }

  /// Integer value for database storage (1-3).
  int get value {
    switch (this) {
      case FlowIntensity.light:
        return 1;
      case FlowIntensity.medium:
        return 2;
      case FlowIntensity.heavy:
        return 3;
    }
  }

  static FlowIntensity fromValue(int value) {
    switch (value) {
      case 1:
        return FlowIntensity.light;
      case 2:
        return FlowIntensity.medium;
      case 3:
        return FlowIntensity.heavy;
      default:
        throw ArgumentError('Invalid FlowIntensity value: $value');
    }
  }
}
