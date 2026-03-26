import 'dart:ui';

import 'ocean_config.dart';

/// A complete color palette for one ocean time period.
class OceanPalette {
  const OceanPalette({
    required this.skyTop,
    required this.skyBottom,
    required this.waterFar,
    required this.waterNear,
    required this.sunGlow,
    required this.caustic,
    required this.foam,
    required this.sparkle,
  });

  final Color skyTop;
  final Color skyBottom;
  final Color waterFar;
  final Color waterNear;
  final Color sunGlow;
  final Color caustic;
  final Color foam;
  final Color sparkle;

  /// Linearly interpolate between two palettes.
  static OceanPalette lerp(OceanPalette a, OceanPalette b, double t) {
    return OceanPalette(
      skyTop: Color.lerp(a.skyTop, b.skyTop, t)!,
      skyBottom: Color.lerp(a.skyBottom, b.skyBottom, t)!,
      waterFar: Color.lerp(a.waterFar, b.waterFar, t)!,
      waterNear: Color.lerp(a.waterNear, b.waterNear, t)!,
      sunGlow: Color.lerp(a.sunGlow, b.sunGlow, t)!,
      caustic: Color.lerp(a.caustic, b.caustic, t)!,
      foam: Color.lerp(a.foam, b.foam, t)!,
      sparkle: Color.lerp(a.sparkle, b.sparkle, t)!,
    );
  }
}

/// Maps local time to an interpolated ocean color palette.
///
/// Six time periods with smooth 30-minute crossfade transitions:
/// Night (22–4), Dawn (4–7), Morning (7–11), Midday (11–15),
/// Sunset (15–19), Dusk (19–22).
abstract class OceanTimeColors {
  // --- Night: 22:00–4:00 ---
  static const _night = OceanPalette(
    skyTop: Color(0xFF050310), // near-black void
    skyBottom: Color(0xFF1A1235), // deep indigo horizon
    waterFar: Color(0xFF0E0B1A), // deepest ocean
    waterNear: Color(0xFF1A3040), // dark teal shore
    sunGlow: Color(0xFF9B7EC4), // lavender moonlight
    caustic: Color(0x229B7EC4), // faint moon caustics
    foam: Color(0x66AADDEE), // ghostly pale blue foam
    sparkle: Color(0x889B7EC4), // lavender moon sparkles
  );

  // --- Dawn: 4:00–7:00 ---
  static const _dawn = OceanPalette(
    skyTop: Color(0xFF2D1B4E), // dark purple lifting
    skyBottom: Color(0xFFE8A090), // soft coral-pink horizon
    waterFar: Color(0xFF3A5070), // steel blue
    waterNear: Color(0xFF2D8A80), // muted teal
    sunGlow: Color(0xFFF0C090), // peach glow
    caustic: Color(0x33F0C090), // warm peach caustics
    foam: Color(0xAAFFEEDD), // warm cream foam
    sparkle: Color(0xCCF0C090), // peach sparkles
  );

  // --- Morning: 7:00–11:00 ---
  static const _morning = OceanPalette(
    skyTop: Color(0xFF5B8CC8), // bright sky blue
    skyBottom: Color(0xFFA0D8E0), // light cyan
    waterFar: Color(0xFF4090A0), // teal-blue depth
    waterNear: Color(0xFF50C8B8), // bright turquoise
    sunGlow: Color(0xFFFFE8A0), // warm yellow
    caustic: Color(0x33FFE8A0), // golden caustics
    foam: Color(0xCCFFFFFF), // bright white foam
    sparkle: Color(0xEEFFE8A0), // golden sparkles
  );

  // --- Midday: 11:00–15:00 ---
  static const _midday = OceanPalette(
    skyTop: Color(0xFF4080C0), // deep sky blue
    skyBottom: Color(0xFF80C8D8), // bright cyan
    waterFar: Color(0xFF3080A0), // ocean blue
    waterNear: Color(0xFF40B8A8), // vivid teal
    sunGlow: Color(0xFFFFF0C0), // bright white-gold
    caustic: Color(0x22FFFFFF), // white caustics
    foam: Color(0xDDFFFFFF), // crisp white foam
    sparkle: Color(0xEEFFFFFF), // white sparkles
  );

  // --- Sunset: 15:00–19:00 (the hero palette) ---
  static const _sunset = OceanPalette(
    skyTop: Color(0xFF6B4C9A), // deep sunset purple
    skyBottom: Color(0xFFE07A6B), // coral-salmon horizon
    waterFar: Color(0xFF5B6FB0), // blue-purple depth
    waterNear: Color(0xFF3DB8A8), // turquoise
    sunGlow: Color(0xFFEDAE5E), // golden amber
    caustic: Color(0x33EDAE5E), // golden caustics
    foam: Color(0xCCFFFFFF), // white foam
    sparkle: Color(0xEEEDAE5E), // golden sparkles
  );

  // --- Dusk: 19:00–22:00 ---
  static const _dusk = OceanPalette(
    skyTop: Color(0xFF3A2060), // dark violet
    skyBottom: Color(0xFF9B5060), // muted rose
    waterFar: Color(0xFF2A3858), // dark steel
    waterNear: Color(0xFF285850), // dark teal
    sunGlow: Color(0xFFC8A0D0), // pale lavender
    caustic: Color(0x22C8A0D0), // lilac caustics
    foam: Color(0x88CCCCDD), // pale lavender foam
    sparkle: Color(0xAAC8A0D0), // lavender sparkles
  );

  /// Ordered list of (startHour, palette) for the 6 periods.
  /// Night wraps: it spans 22:00 -> 4:00 across midnight.
  static const List<(double, OceanPalette)> _periods = [
    (0.0, _night), // midnight continuation of night
    (4.0, _dawn),
    (7.0, _morning),
    (11.0, _midday),
    (15.0, _sunset),
    (19.0, _dusk),
    (22.0, _night), // night begins again
  ];

  /// Returns the interpolated palette for the current local time.
  ///
  /// Call this from a Timer.periodic or on build. The result is
  /// passed as shader uniforms.
  static OceanPalette forTime(DateTime time) {
    final hour = time.hour + time.minute / 60.0;
    return forHour(hour);
  }

  /// Returns the interpolated palette for a given fractional hour (0.0–24.0).
  static OceanPalette forHour(double hour) {
    // Clamp to valid range
    hour = hour % 24.0;

    // Find the surrounding period pair
    int idx = 0;
    for (int i = _periods.length - 1; i >= 0; i--) {
      if (hour >= _periods[i].$1) {
        idx = i;
        break;
      }
    }

    final (startHour, startPalette) = _periods[idx];
    final nextIdx = (idx + 1) % _periods.length;
    final (endHour, endPalette) = _periods[nextIdx];

    // Calculate transition progress
    final windowMinutes = OceanConfig.transitionWindowMinutes;
    final periodDuration = endHour > startHour
        ? endHour - startHour
        : (24.0 - startHour) + endHour;

    final elapsed = hour >= startHour
        ? hour - startHour
        : (24.0 - startHour) + hour;

    // Before transition window: use start palette
    // During transition window (last 30 min before next period): blend
    // After transition: next palette
    final transitionStart = periodDuration - (windowMinutes / 60.0);

    if (elapsed <= transitionStart) {
      return startPalette;
    }

    final t =
        ((elapsed - transitionStart) / (windowMinutes / 60.0)).clamp(0.0, 1.0);
    return OceanPalette.lerp(startPalette, endPalette, t);
  }
}
