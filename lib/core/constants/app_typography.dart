import 'package:flutter/material.dart';

import 'app_colors.dart';

/// All text style constants for the Cara app.
///
/// Uses the system font stack. No external font dependency required.
/// All styles are defined against [AppColors.textPrimary] and can be
/// overridden with [TextStyle.copyWith] at call sites.
abstract class AppTypography {
  // -------------------------------------------------------------------
  // Heading styles
  // -------------------------------------------------------------------

  /// 28sp semi-bold — page titles, main headings.
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// 22sp semi-bold — section titles.
  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// 18sp semi-bold — card titles, sub-section headings.
  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // -------------------------------------------------------------------
  // Body styles
  // -------------------------------------------------------------------

  /// 16sp regular — primary body text, labels.
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// 14sp regular — secondary body text, descriptions.
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // -------------------------------------------------------------------
  // Supporting styles
  // -------------------------------------------------------------------

  /// 12sp regular — captions, timestamps, helper text.
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// 32sp monospace medium — PIN pad digits, numeric displays.
  static const TextStyle pinDigit = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontFamily: 'monospace',
    letterSpacing: 2.0,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// 14sp medium — button labels.
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.surface,
    height: 1.2,
  );

  /// 12sp medium — chip labels, badge text.
  static const TextStyle chip = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  /// 10sp regular — very small labels, day-of-week headers.
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.0,
    color: AppColors.textSecondary,
    height: 1.2,
  );
}
