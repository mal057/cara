import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A single row inside a [SettingsSection].
///
/// Composes a leading icon container, a [title] + optional [subtitle] column,
/// and an optional [trailing] widget (e.g., a [Switch], chevron, or badge).
///
/// When [onTap] is provided the entire tile is tappable with an ink ripple.
/// When [isDestructive] is true the icon and title are rendered in
/// [AppColors.error] to signal a dangerous action.
///
/// All touch targets are at least [AppSizes.settingsTileHeight] (56 dp).
///
/// Example:
/// ```dart
/// // Navigation tile
/// SettingsTile(
///   icon: Icons.lock_outline_rounded,
///   title: 'Change PIN',
///   onTap: () => _showPinChange(context),
/// )
///
/// // Toggle tile
/// SettingsTile(
///   icon: Icons.notifications_outlined,
///   title: 'Period reminder',
///   subtitle: 'Notified 2 days before',
///   trailing: Switch(value: enabled, onChanged: _toggle),
/// )
///
/// // Destructive tile
/// SettingsTile(
///   icon: Icons.delete_outline_rounded,
///   title: 'Delete all data',
///   isDestructive: true,
///   onTap: () => _confirmDelete(context),
/// )
/// ```
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.enabled = true,
  });

  /// Icon displayed in the leading container.
  final IconData icon;

  /// Primary label for this setting row.
  final String title;

  /// Optional secondary description shown below [title].
  final String? subtitle;

  /// Widget anchored to the right of the row (e.g., Switch, Text, Icon).
  final Widget? trailing;

  /// Tap callback. When null the tile is not interactive.
  final VoidCallback? onTap;

  /// When true, renders icon and title in [AppColors.error].
  final bool isDestructive;

  /// When false, dims the tile and ignores taps.
  final bool enabled;

  Color get _iconColor =>
      isDestructive ? AppColors.error : AppColors.primary;

  Color get _titleColor =>
      isDestructive ? AppColors.error : AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    final tile = Semantics(
      button: onTap != null,
      enabled: enabled,
      label: title,
      hint: subtitle,
      child: InkWell(
        onTap: enabled && onTap != null
            ? () {
                HapticFeedback.selectionClick();
                onTap!();
              }
            : null,
        child: Opacity(
          opacity: enabled ? 1.0 : 0.45,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppSizes.settingsTileHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.pagePadding,
                vertical: AppSizes.space12,
              ),
              child: Row(
                children: [
                  // Leading icon
                  _LeadingIconBox(
                    icon: icon,
                    color: _iconColor,
                  ),
                  const SizedBox(width: AppSizes.space12),
                  // Title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: AppTypography.body1.copyWith(
                            color: _titleColor,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: AppSizes.space2),
                          Text(
                            subtitle!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Trailing
                  if (trailing != null) ...[
                    const SizedBox(width: AppSizes.space8),
                    trailing!,
                  ] else if (onTap != null) ...[
                    const SizedBox(width: AppSizes.space8),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textSecondary,
                      size: AppSizes.iconMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return tile;
  }
}

/// Small rounded-square container that holds the leading [icon].
class _LeadingIconBox extends StatelessWidget {
  const _LeadingIconBox({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Icon(icon, color: color, size: AppSizes.iconMedium - 2),
    );
  }
}
