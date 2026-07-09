import 'package:flutter/material.dart';

/// Renders an emoji [Text] when available, otherwise a Material [Icon].
///
/// Mood symptoms have an emoji string; all other categories use their
/// Material icon. The [size] controls the icon size and (with a small
/// boost) the emoji font size so they appear visually similar.
class SymptomIcon extends StatelessWidget {
  const SymptomIcon({
    super.key,
    required this.icon,
    this.emoji,
    this.size = 16,
    this.color,
  });

  /// Material icon fallback (always required for non-mood symptoms).
  final IconData icon;

  /// Emoji string for mood symptoms. When non-null, rendered instead of [icon].
  final String? emoji;

  /// Logical size. Icons use this directly; emoji text uses `size + 2` for
  /// visual parity with Material icons at the same nominal size.
  final double size;

  /// Icon colour (ignored when rendering emoji — emoji has its own colours).
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (emoji != null) {
      return Text(emoji!, style: TextStyle(fontSize: size + 2));
    }
    return Icon(icon, size: size, color: color);
  }
}
