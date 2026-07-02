import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the global theme for the SpeedTrack application.
class AppTheme {
  AppTheme._();

  static const Color _primaryColor = Color(0xFF00FF7F); // Spring Green
  static const Color _backgroundColorDark = Color(0xFF121212);
  static const Color _surfaceColorDark = Color(0xFF1E1E1E);

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.dark,
        surface: _surfaceColorDark,
      ),
      scaffoldBackgroundColor: _backgroundColorDark,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}
