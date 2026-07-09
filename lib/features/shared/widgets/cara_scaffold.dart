import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// App-wide scaffold wrapper that enforces consistent padding, safe-area
/// handling, and the warm-white background from the design system.
///
/// Use this instead of a bare [Scaffold] on every screen to guarantee
/// visual consistency.
///
/// Example:
/// ```dart
/// CaraScaffold(
///   title: 'Calendar',
///   child: CalendarContent(),
/// )
/// ```
class CaraScaffold extends StatelessWidget {
  const CaraScaffold({
    super.key,
    required this.child,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.pagePadding,
    ),
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
  }) : assert(
          title == null || titleWidget == null,
          'Provide either title or titleWidget, not both.',
        );

  /// Screen title displayed in the app bar. Mutually exclusive with
  /// [titleWidget].
  final String? title;

  /// Custom title widget for the app bar. Mutually exclusive with [title].
  final Widget? titleWidget;

  /// Optional action icons in the top-right of the app bar.
  final List<Widget>? actions;

  /// Optional custom leading widget (replaces the default back button).
  final Widget? leading;

  /// Bottom navigation bar, typically a [CaraBottomNav].
  final Widget? bottomNavigationBar;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Whether the scaffold resizes when the keyboard appears.
  final bool resizeToAvoidBottomInset;

  /// Padding applied to the [child] content area. Defaults to horizontal
  /// [AppSizes.pagePadding]. Pass [EdgeInsets.zero] for full-bleed layouts
  /// such as the calendar screen.
  final EdgeInsetsGeometry padding;

  /// Background color. Defaults to [AppColors.background].
  final Color? backgroundColor;

  /// Whether to draw the body behind the app bar.
  final bool extendBodyBehindAppBar;

  /// Whether to extend the body behind the bottom nav bar.
  final bool extendBody;

  /// The main screen content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool hasAppBar = title != null || titleWidget != null || actions != null || leading != null;

    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      appBar: hasAppBar
          ? AppBar(
              title: titleWidget ?? (title != null ? Text(title!) : null),
              actions: actions,
              leading: leading,
              // Inherits transparent bg + no elevation from CaraLightTheme.
            )
          : null,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        // Bottom safe-area is handled by the bottom nav bar itself when
        // present; disable it here to avoid double-padding.
        bottom: bottomNavigationBar == null,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
