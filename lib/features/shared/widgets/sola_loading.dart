import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_typography.dart';

/// A skeleton loading widget for async states throughout the Sola app.
///
/// Two modes:
///
/// 1. **Skeleton** (default) — shimmer-animated rounded rectangles that
///    mimic the shape of the content being loaded. Construct via
///    [SolaLoading.skeleton] or the default constructor with
///    [SolaLoadingStyle.skeleton].
///
/// 2. **Spinner** — a centered [CircularProgressIndicator] tinted with
///    [AppColors.primary], optionally accompanied by a [message] label.
///    Construct via [SolaLoading.spinner].
///
/// Examples:
/// ```dart
/// // Inline spinner with message
/// SolaLoading.spinner(message: 'Opening secure database…')
///
/// // Skeleton — 3 card-shaped placeholders
/// SolaLoading.skeleton(rows: 3)
///
/// // Skeleton — single line placeholder
/// SolaLoading.skeleton(rows: 1, rowHeight: 16)
/// ```
class SolaLoading extends StatefulWidget {
  /// Creates a [SolaLoading] widget using [style].
  const SolaLoading({
    super.key,
    this.style = SolaLoadingStyle.skeleton,
    this.rows = 3,
    this.rowHeight = _kDefaultRowHeight,
    this.rowSpacing = AppSizes.space12,
    this.message,
  });

  /// Named constructor that produces a spinner variant.
  const SolaLoading.spinner({
    super.key,
    this.message,
  })  : style = SolaLoadingStyle.spinner,
        rows = 1,
        rowHeight = _kDefaultRowHeight,
        rowSpacing = AppSizes.space12;

  /// Named constructor that produces a skeleton variant.
  const SolaLoading.skeleton({
    super.key,
    this.rows = 3,
    this.rowHeight = _kDefaultRowHeight,
    this.rowSpacing = AppSizes.space12,
  })  : style = SolaLoadingStyle.skeleton,
        message = null;

  static const double _kDefaultRowHeight = 72.0;

  /// Visual style to use.
  final SolaLoadingStyle style;

  /// Number of skeleton rows to render. Ignored for [SolaLoadingStyle.spinner].
  final int rows;

  /// Height of each skeleton row in logical pixels.
  final double rowHeight;

  /// Vertical gap between skeleton rows.
  final double rowSpacing;

  /// Optional message shown below the spinner. Ignored for skeleton style.
  final String? message;

  @override
  State<SolaLoading> createState() => _SolaLoadingState();
}

class _SolaLoadingState extends State<SolaLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.style) {
      SolaLoadingStyle.skeleton => _buildSkeleton(context),
      SolaLoadingStyle.spinner => _buildSpinner(context),
    };
  }

  // ---------------------------------------------------------------------------
  // Skeleton
  // ---------------------------------------------------------------------------

  Widget _buildSkeleton(BuildContext context) {
    return Semantics(
      label: 'Loading content',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.rows, (index) {
          final bool isLast = index == widget.rows - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : widget.rowSpacing),
            child: _SkeletonRow(
              height: widget.rowHeight,
              animation: _shimmerAnimation,
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Spinner
  // ---------------------------------------------------------------------------

  Widget _buildSpinner(BuildContext context) {
    return Semantics(
      label: widget.message ?? 'Loading',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppSizes.iconLarge,
            height: AppSizes.iconLarge,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              backgroundColor: AppColors.primary.withAlpha(26),
            ),
          ),
          if (widget.message != null) ...[
            const SizedBox(height: AppSizes.space16),
            Text(
              widget.message!,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skeleton row
// ---------------------------------------------------------------------------

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow({
    required this.height,
    required this.animation,
  });

  final double height;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            gradient: LinearGradient(
              begin: Alignment(animation.value - 1, 0),
              end: Alignment(animation.value, 0),
              colors: const [
                Color(0xFFEDE8E0),
                Color(0xFFDDD6CA),
                Color(0xFFEDE8E0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Enum
// ---------------------------------------------------------------------------

/// Visual style for [SolaLoading].
enum SolaLoadingStyle {
  /// Shimmer-animated placeholder rectangles.
  skeleton,

  /// Circular progress indicator with optional message.
  spinner,
}

// ---------------------------------------------------------------------------
// Convenience builders for common screen-level states
// ---------------------------------------------------------------------------

/// Wraps a full-screen centered loading state. Used in [AsyncValue.when]
/// `loading` branches for screens that have no prior content to show.
///
/// Example:
/// ```dart
/// ref.watch(someProvider).when(
///   loading: () => const SolaLoadingScreen(),
///   error: (e, s) => ErrorScreen(error: e),
///   data: (data) => MyContent(data: data),
/// )
/// ```
class SolaLoadingScreen extends StatelessWidget {
  const SolaLoadingScreen({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.space32),
        child: SolaLoading.spinner(message: message),
      ),
    );
  }
}
