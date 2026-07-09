import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_typography.dart';

/// Dark [ThemeData] for the Cara app.
///
/// Uses Material 3 with [AppColors.darkBackground] / [AppColors.darkSurface]
/// as the canvas. Phase colours remain vivid against the dark backgrounds.
/// Text uses [AppColors.darkTextPrimary] and [AppColors.darkTextSecondary].
ThemeData caraDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.darkTextPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.darkTextPrimary,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    surfaceContainerHighest: AppColors.darkBackground,
    error: AppColors.error,
    onError: AppColors.darkTextPrimary,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkDivider,
    scrim: AppColors.scrim,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    splashFactory: InkRipple.splashFactory,
    textTheme: _buildDarkTextTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: AppTypography.heading3.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkTextPrimary,
        size: AppSizes.iconMedium,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.darkTextSecondary,
      elevation: AppSizes.elevationSheet,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTypography.overline.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTypography.overline.copyWith(
        color: AppColors.darkTextSecondary,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      indicatorColor: AppColors.primary.withAlpha(51),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.secondary,
            size: AppSizes.iconMedium,
          );
        }
        return const IconThemeData(
          color: AppColors.darkTextSecondary,
          size: AppSizes.iconMedium,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.overline.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.overline.copyWith(color: AppColors.darkTextSecondary);
      }),
      elevation: AppSizes.elevationSheet,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: AppSizes.elevationCard,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.space4,
        vertical: AppSizes.space4,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      hintStyle: AppTypography.body2.copyWith(color: AppColors.darkTextSecondary),
      labelStyle: AppTypography.body2.copyWith(color: AppColors.darkTextSecondary),
      floatingLabelStyle: AppTypography.caption.copyWith(
        color: AppColors.secondary,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space16,
        vertical: AppSizes.space16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.darkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.darkTextPrimary,
        minimumSize: const Size(0, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        textStyle: AppTypography.button.copyWith(
          color: AppColors.darkTextPrimary,
          letterSpacing: 1.2,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondary,
        minimumSize: const Size(0, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        textStyle: AppTypography.button.copyWith(
          color: AppColors.secondary,
          letterSpacing: 1.0,
        ),
        side: BorderSide(color: AppColors.secondary.withAlpha(140), width: 1.5),
        backgroundColor: AppColors.secondary.withAlpha(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary,
        minimumSize: const Size(AppSizes.touchTarget, AppSizes.touchTarget),
        textStyle: AppTypography.button.copyWith(color: AppColors.secondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      modalBackgroundColor: AppColors.darkSurface,
      elevation: AppSizes.elevationSheet,
      modalElevation: AppSizes.elevationSheet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: AppSizes.elevationDialog,
      titleTextStyle: AppTypography.heading3.copyWith(color: AppColors.darkTextPrimary),
      contentTextStyle: AppTypography.body2.copyWith(color: AppColors.darkTextSecondary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
      space: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkBackground,
      labelStyle: AppTypography.chip.copyWith(color: AppColors.darkTextPrimary),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space12,
        vertical: AppSizes.space4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        side: const BorderSide(color: AppColors.darkOutline),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurface,
      contentTextStyle: AppTypography.body2.copyWith(color: AppColors.darkTextPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
      minVerticalPadding: AppSizes.space12,
      minLeadingWidth: AppSizes.iconMedium,
      titleTextStyle: AppTypography.body1.copyWith(color: AppColors.darkTextPrimary),
      subtitleTextStyle: AppTypography.body2.copyWith(color: AppColors.darkTextSecondary),
      iconColor: AppColors.darkTextSecondary,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.darkBackground;
        return AppColors.darkTextSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.secondary;
        return AppColors.darkOutline;
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: AppSizes.elevationCard,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkTextPrimary,
      size: AppSizes.iconMedium,
    ),
  );
}

TextTheme _buildDarkTextTheme(Color primary, Color secondary) {
  return TextTheme(
    displayLarge: AppTypography.heading1.copyWith(fontSize: 57, color: primary),
    displayMedium: AppTypography.heading1.copyWith(fontSize: 45, color: primary),
    displaySmall: AppTypography.heading1.copyWith(color: primary),
    headlineLarge: AppTypography.heading1.copyWith(color: primary),
    headlineMedium: AppTypography.heading2.copyWith(color: primary),
    headlineSmall: AppTypography.heading3.copyWith(color: primary),
    titleLarge: AppTypography.heading3.copyWith(color: primary),
    titleMedium: AppTypography.body1.copyWith(fontWeight: FontWeight.w600, color: primary),
    titleSmall: AppTypography.body2.copyWith(fontWeight: FontWeight.w600, color: primary),
    bodyLarge: AppTypography.body1.copyWith(color: primary),
    bodyMedium: AppTypography.body2.copyWith(color: primary),
    bodySmall: AppTypography.caption.copyWith(color: secondary),
    labelLarge: AppTypography.button.copyWith(color: primary),
    labelMedium: AppTypography.chip.copyWith(color: primary),
    labelSmall: AppTypography.overline.copyWith(color: secondary),
  );
}