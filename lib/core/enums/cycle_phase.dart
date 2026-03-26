enum CyclePhase {
  menstrual,
  follicular,
  ovulatory,
  luteal;

  String get displayName {
    switch (this) {
      case CyclePhase.menstrual:
        return 'Menstrual';
      case CyclePhase.follicular:
        return 'Follicular';
      case CyclePhase.ovulatory:
        return 'Ovulatory';
      case CyclePhase.luteal:
        return 'Luteal';
    }
  }

  String get description {
    switch (this) {
      case CyclePhase.menstrual:
        return 'Menstrual Phase';
      case CyclePhase.follicular:
        return 'Follicular Phase';
      case CyclePhase.ovulatory:
        return 'Ovulatory Phase';
      case CyclePhase.luteal:
        return 'Luteal Phase';
    }
  }
}
