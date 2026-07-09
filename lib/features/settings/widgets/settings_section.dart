import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A titled group container for settings rows.
///
/// Renders the section [title] in purple uppercase overline text above a
/// white card-like surface that clips its [children] with rounded corners.
/// A [Divider] is drawn between each child automatically.
///
/// Example:
/// ```dart
/// SettingsSection(
///   title: 'Security',
///   children: [
///     SettingsTile(...),
///     SettingsTile(...),
///   ],
/// )
/// ```
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  /// Section heading displayed above the tile group (e.g., 'Cycle').
  final String title;

  /// List of widgets — typically [SettingsTile] instances — displayed inside
  /// the section card.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.space4,
            bottom: AppSizes.space8,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        // Tile container
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(13),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: _buildDividedChildren(children),
          ),
        ),
      ],
    );
  }

  /// Inserts a 1 dp [Divider] between every consecutive pair of children.
  static List<Widget> _buildDividedChildren(List<Widget> items) {
    if (items.isEmpty) return [];
    final result = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(const Divider(
          height: 1,
          thickness: 1,
          indent: AppSizes.pagePadding,
          endIndent: 0,
          color: AppColors.divider,
        ));
      }
    }
    return result;
  }
}
