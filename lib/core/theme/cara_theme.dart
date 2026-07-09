import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_typography.dart';

/// Light [ThemeData] for the Cara app.
///
/// Uses Material 3, seeded from [AppColors.primary], with every colour slot
/// and component theme explicitly mapped to the Cara design system.
ThemeData caraLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.surface,
    secondary: AppColors.secondary,
    onSecondary: AppColors.surface,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.background,
    error: AppColors.error,
    onError: AppColors.surface,
    outline: AppColors.inputBorder,
    outlineVariant: AppColors.divider,
    scrim: AppColors.scrim,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    splashFactory: InkRipple.splashFactory,
    textTheme: _buildTextTheme(AppColors.textPrimary, AppColors.textSecondary),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      titleTextStyle: AppTypography.heading3.copyWith(
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppSizes.iconMedium,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      elevation: AppSizes.elevationSheet,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTypography.overline.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTypography.overline.copyWith(
        color: AppColors.textSecondary,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primary.withAlpha(26),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: AppColors.primary,
            size: AppSizes.iconMedium,
          );
        }
        return const IconThemeData(
          color: AppColors.textSecondary,
          size: AppSizes.iconMedium,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.overline.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return AppTypography.overline.copyWith(color: AppColors.textSecondary);
      }),
      elevation: AppSizes.elevationSheet,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: AppSizes.elevationCard,
      shadowColor: AppColors.primary.withAlpha(31),
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
      fillColor: AppColors.surface,
      hintStyle: AppTypography.body2.copyWith(color: AppColors.textSecondary),
      labelStyle: AppTypography.body2.copyWith(color: AppColors.textSecondary),
      floatingLabelStyle: AppTypography.caption.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space16,
        vertical: AppSizes.space16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
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
        foregroundColor: AppColors.surface,
        minimumSize: const Size(0, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        textStyle: AppTypography.button.copyWith(letterSpacing: 1.2),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(0, AppSizes.buttonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
        textStyle: AppTypography.button.copyWith(letterSpacing: 1.0),
        side: BorderSide(color: AppColors.primary.withAlpha(140), width: 1.5),
        backgroundColor: AppColors.primary.withAlpha(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(AppSizes.touchTarget, AppSizes.touchTarget),
        textStyle: AppTypography.button.copyWith(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      modalBackgroundColor: AppColors.surface,
      elevation: AppSizes.elevationSheet,
      modalElevation: AppSizes.elevationSheet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppSizes.elevationDialog,
      titleTextStyle: AppTypography.heading3,
      contentTextStyle: AppTypography.body2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.background,
      labelStyle: AppTypography.chip,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.space12,
        vertical: AppSizes.space4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        side: const BorderSide(color: AppColors.divider),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: AppTypography.body2.copyWith(color: AppColors.surface),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding),
      minVerticalPadding: AppSizes.space12,
      minLeadingWidth: AppSizes.iconMedium,
      titleTextStyle: AppTypography.body1,
      subtitleTextStyle: AppTypography.body2,
      iconColor: AppColors.textSecondary,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.surface;
        return AppColors.textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.divider;
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      elevation: AppSizes.elevationCard,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSizes.iconMedium,
    ),
  );
}

TextTheme _buildTextTheme(Color primary, Color secondary) {
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
    labelLarge: AppTypography.button,
    labelMedium: AppTypography.chip.copyWith(color: primary),
    labelSmall: AppTypography.overline.copyWith(color: secondary),
  );
}