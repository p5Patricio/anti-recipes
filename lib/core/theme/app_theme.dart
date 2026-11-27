import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Application theme (Material 3) built explicitly from [AppColors].
abstract final class AppTheme {
  static ThemeData dark() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.inkRed,
      onPrimary: AppColors.cream,
      secondary: AppColors.blossom,
      onSecondary: AppColors.ink,
      tertiary: AppColors.kraft,
      onTertiary: AppColors.ink,
      error: AppColors.error,
      onError: AppColors.ink,
      surface: AppColors.surface,
      onSurface: AppColors.cream,
      onSurfaceVariant: AppColors.creamMuted,
      surfaceContainerHighest: AppColors.surfaceRaised,
      outline: AppColors.outline,
      outlineVariant: AppColors.outline,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.outline, width: 1.5),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.ink,
      canvasColor: AppColors.ink,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.inkRed,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.cream
                : AppColors.creamMuted,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppColors.cream
                : AppColors.creamMuted,
          ),
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.outline, width: 1.5),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.surfaceRaised,
        labelStyle: TextStyle(color: AppColors.cream),
        side: BorderSide(color: AppColors.outline),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.outline),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.inkRed,
          foregroundColor: AppColors.cream,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.blossom),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.inkRed,
        foregroundColor: AppColors.cream,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.blossom, width: 2),
        ),
      ),
    );
  }
}
