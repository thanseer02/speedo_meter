import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedtrack/core/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displaySpeed => GoogleFonts.outfit(
        fontSize: 96,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -2.0,
      );

  static TextStyle get heading1 => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get body1 => GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get body2 => GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  static TextStyle get label => GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      );

  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: displaySpeed,
      headlineLarge: heading1,
      headlineMedium: heading2,
      bodyLarge: body1,
      bodyMedium: body2,
      labelSmall: label,
    );
  }
}
