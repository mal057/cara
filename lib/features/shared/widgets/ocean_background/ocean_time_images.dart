import 'package:flutter/foundation.dart';

import 'ocean_config.dart';

enum OceanPeriod { night, dawn, morning, midday, sunset, dusk }

abstract class OceanTimeImages {
  static const String _fakeHourEnv =
      String.fromEnvironment('FAKE_HOUR', defaultValue: '');

  /// Debug-only override hour, set via `--dart-define=FAKE_HOUR=NN`.
  /// Returns null in release builds or when the flag is absent/unparseable.
  static double? debugHour() {
    if (!kDebugMode) return null;
    if (_fakeHourEnv.isEmpty) return null;
    final h = double.tryParse(_fakeHourEnv);
    if (h == null) return null;
    return h % 24.0;
  }

  /// Returns DateTime.now() in normal builds; in debug builds with FAKE_HOUR
  /// set, returns today's date with the hour/minute pinned to the override.
  static DateTime currentTime() {
    final override = debugHour();
    if (override == null) return DateTime.now();
    final now = DateTime.now();
    final whole = override.floor();
    final mins = ((override - whole) * 60).round();
    return DateTime(now.year, now.month, now.day, whole, mins);
  }

  static const List<(double, OceanPeriod)> _periods = [
    (0.0, OceanPeriod.night),
    (4.0, OceanPeriod.dawn),
    (7.0, OceanPeriod.morning),
    (11.0, OceanPeriod.midday),
    (15.0, OceanPeriod.sunset),
    (19.0, OceanPeriod.dusk),
    (22.0, OceanPeriod.night),
  ];

  static String assetPath(OceanPeriod period, int frameIndex) {
    return 'assets/images/ocean/${period.name}_$frameIndex.png';
  }

  static String videoAssetPath(OceanPeriod period) =>
      'assets/videos/${period.name}_ocean.mp4';

  static (OceanPeriod current, OceanPeriod next, double blend) forTime(DateTime time) {
    final hour = time.hour + time.minute / 60.0;
    return forHour(hour);
  }

  static (OceanPeriod current, OceanPeriod next, double blend) forHour(double hour) {
    hour = hour % 24.0;
    int idx = 0;
    for (int i = _periods.length - 1; i >= 0; i--) {
      if (hour >= _periods[i].$1) {
        idx = i;
        break;
      }
    }
    final (startHour, startPeriod) = _periods[idx];
    final nextIdx = (idx + 1) % _periods.length;
    final (endHour, nextPeriod) = _periods[nextIdx];
    final windowMinutes = OceanConfig.transitionWindowMinutes;
    final periodDuration = endHour > startHour
        ? endHour - startHour
        : (24.0 - startHour) + endHour;
    final elapsed = hour >= startHour
        ? hour - startHour
        : (24.0 - startHour) + hour;
    final transitionStart = periodDuration - (windowMinutes / 60.0);
    if (elapsed <= transitionStart) {
      return (startPeriod, startPeriod, 0.0);
    }
    final t =
        ((elapsed - transitionStart) / (windowMinutes / 60.0)).clamp(0.0, 1.0);
    return (startPeriod, nextPeriod, t);
  }
}
