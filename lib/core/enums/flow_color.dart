enum FlowColor {
  red,
  darkRed,
  brown,
  pink;

  String get displayName {
    switch (this) {
      case FlowColor.red:
        return 'Red';
      case FlowColor.darkRed:
        return 'Dark Red';
      case FlowColor.brown:
        return 'Brown';
      case FlowColor.pink:
        return 'Pink';
    }
  }

  /// Hex color string for display swatch.
  String get hexColor {
    switch (this) {
      case FlowColor.red:
        return '#C0392B';
      case FlowColor.darkRed:
        return '#7B1818';
      case FlowColor.brown:
        return '#795548';
      case FlowColor.pink:
        return '#F48FB1';
    }
  }

  static FlowColor fromString(String value) {
    switch (value) {
      case 'red':
        return FlowColor.red;
      case 'darkRed':
        return FlowColor.darkRed;
      case 'brown':
        return FlowColor.brown;
      case 'pink':
        return FlowColor.pink;
      default:
        throw ArgumentError('Invalid FlowColor value: $value');
    }
  }
}
