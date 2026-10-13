import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Liftly Master Design System Color Tokens
class AppColors {
  // Dark Theme Tokens (Default)
  static const Color darkBackground = Color(0xFF080B0E);
  static const Color darkSurface = Color(0xFF10171D);
  static const Color darkSurfaceElevated = Color(0xFF131C23);
  static const Color darkTextPrimary = Color(0xFFF5F7FA);
  static const Color darkTextSecondary = Color(0xFF93A7BD);
  static const Color darkBorder = Color(0xFF1D3039);

  // Light Theme Tokens
  static const Color lightBackground = Color(0xFFF4F7F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFEDF2F4);
  static const Color lightTextPrimary = Color(0xFF15212A);
  static const Color lightTextSecondary = Color(0xFF637585);
  static const Color lightBorder = Color(0xFFDCE5E9);

  // Universal Brand Accents
  static const Color neonLime = Color(0xFFC4FF5A);
  static const Color electricCyan = Color(0xFF00D9FF);
  static const Color goldAccent = Color(0xFFFFD166);
  static const Color textDark = Color(0xFF080B0E);

  // Gradients
  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonLime, electricCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBorderGradient = LinearGradient(
    colors: [
      Color(0x99C4FF5A), // 60% neon lime
      Color(0x5500D9FF), // 33% electric cyan
      Color(0x331D3039), // subtle border blend
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Global theme mode state controller
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.dark);

/// Extension for convenient theme-aware color retrieval
extension LiftlyThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor =>
      isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
  Color get surfaceColor =>
      isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;
  Color get surfaceElevatedColor => isDarkMode
      ? AppColors.darkSurfaceElevated
      : AppColors.lightSurfaceElevated;
  Color get textPrimaryColor =>
      isDarkMode ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  Color get textSecondaryColor =>
      isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  Color get borderColor =>
      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;
}

class AppTheme {
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.manropeTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonLime,
        secondary: AppColors.electricCyan,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
      ),
      textTheme: textTheme.apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
    );
  }

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.manropeTextTheme(
      ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.neonLime,
        secondary: AppColors.electricCyan,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
      ),
      textTheme: textTheme.apply(
        bodyColor: AppColors.lightTextPrimary,
        displayColor: AppColors.lightTextPrimary,
      ),
    );
  }
}
