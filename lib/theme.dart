import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LuminousColors {
  static const surface = Color(0xFFFBF9F9);
  static const onSurface = Color(0xFF1A1A1A);
  static const containerLow = Color(0xFFF5F3F3);
  static const accent = Color(0xFF1A1A1A);
  static const white = Colors.white;
  static const grey = Colors.grey;
}

ThemeData luminousTheme() {
  final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: LuminousColors.surface,
    colorScheme: const ColorScheme.light(
      surface: LuminousColors.surface,
      onSurface: LuminousColors.onSurface,
      primary: LuminousColors.onSurface,
      onPrimary: LuminousColors.white,
      secondary: LuminousColors.containerLow,
      onSecondary: LuminousColors.onSurface,
    ),
    textTheme: baseTextTheme.copyWith(
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        color: LuminousColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        color: LuminousColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        color: LuminousColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: LuminousColors.onSurface,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: LuminousColors.onSurface,
      ),
    ),
    cardTheme: CardThemeData(
      color: LuminousColors.containerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LuminousColors.onSurface,
        foregroundColor: LuminousColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LuminousColors.containerLow,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: LuminousColors.surface,
      foregroundColor: LuminousColors.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        color: LuminousColors.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
