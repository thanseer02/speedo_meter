import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speedtrack/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('Initial theme mode should be system', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, ThemeMode.system);
      expect(themeProvider.isDarkMode, false);
    });

    test('Toggling theme to true sets dark mode', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme(true);
      expect(themeProvider.themeMode, ThemeMode.dark);
      expect(themeProvider.isDarkMode, true);
    });

    test('Toggling theme to false sets light mode', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme(false);
      expect(themeProvider.themeMode, ThemeMode.light);
      expect(themeProvider.isDarkMode, false);
    });

    test('setThemeMode sets the exact mode', () {
      final themeProvider = ThemeProvider();
      themeProvider.setThemeMode(ThemeMode.dark);
      expect(themeProvider.themeMode, ThemeMode.dark);
    });
  });
}
