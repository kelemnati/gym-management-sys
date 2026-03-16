import 'package:flutter/material.dart';

/// Central theme configuration for the app.
///
/// This file defines the light/dark themes and typography used across the app.
class AppTheme {
  // Primary brand colors
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep blue
  static const Color secondaryColor = Color(0xFF10B981); // Emerald
  static const Color accentColor = Color(0xFFF59E0B); // Amber

  // Light theme colors
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightOnSurface = Colors.black;

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0B1220);
  static const Color darkSurface = Color(0xFF131F3A);
  static const Color darkOnSurface = Colors.white;

  static const Color errorColor = Color(0xFFEF4444);

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: accentColor,
    surface: lightSurface,
    onSurface: lightOnSurface,
    error: errorColor,
  );

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: accentColor,
    surface: darkSurface,
    onSurface: darkOnSurface,
    error: errorColor,
  );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightBackground,
        appBarTheme: _appBarTheme(lightColorScheme),
        elevatedButtonTheme: _elevatedButtonTheme(lightColorScheme),
        cardTheme: _cardTheme(lightColorScheme),
        inputDecorationTheme: _inputDecorationTheme(lightColorScheme),
        textTheme: AppTypography.textTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: _appBarTheme(darkColorScheme),
        elevatedButtonTheme: _elevatedButtonTheme(darkColorScheme),
        cardTheme: _cardTheme(darkColorScheme),
        inputDecorationTheme: _inputDecorationTheme(darkColorScheme),
        textTheme: AppTypography.textTheme.apply(
          bodyColor: darkOnSurface,
          displayColor: darkOnSurface,
        ),
      );

  static AppBarTheme _appBarTheme(ColorScheme colors) => AppBarTheme(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      );

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static CardThemeData _cardTheme(ColorScheme colors) => CardThemeData(
        elevation: 2,
        color: colors.surface,
        surfaceTintColor: colors.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colors) =>
      InputDecorationTheme(
        filled: true,
        fillColor: colors.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
      );
}

/// Shared typography definitions used throughout the app.
class AppTypography {
  static const TextStyle headline1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: headline1,
    displayMedium: headline2,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    labelLarge: label,
  );
}
