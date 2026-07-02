import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core Backgrounds
  static const Color background = Color(0xFF000000); // OLED Black
  static const Color surface = Color(0xFF1A1C23);    // Matte Charcoal

  // Accents
  static const Color primary = Color(0xFFCCFF00);    // Volt Neon
  static const Color secondary = Color(0xFF00E5FF);  // Electric Cyan
  static const Color destructive = Color(0xFFFF3366); // Pulse Red

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure White
  static const Color textSecondary = Color(0xFF8E92A4); // Slate Grey

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFAEEA00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
