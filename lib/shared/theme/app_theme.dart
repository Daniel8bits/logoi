import 'package:flutter/material.dart';

/// App theme modes (docs/06_UI_UX.md §5.2: light / dark / sepia).
enum LogoiThemeMode { light, dark, sepia }

/// Design tokens and theme construction.
class AppTheme {
  AppTheme._();

  static const seed = Color(0xFF4F5B93);

  static const highlightColors = <String, Color>{
    '#FFEB3B': Color(0xFFFFEB3B),
    '#A5D6A7': Color(0xFFA5D6A7),
    '#90CAF9': Color(0xFF90CAF9),
    '#F48FB1': Color(0xFFF48FB1),
    '#FFCC80': Color(0xFFFFCC80),
    '#CE93D8': Color(0xFFCE93D8),
  };

  static ThemeData of(LogoiThemeMode mode) => switch (mode) {
        LogoiThemeMode.light => _base(
            ColorScheme.fromSeed(seedColor: seed),
          ),
        LogoiThemeMode.dark => _base(
            ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
          ),
        LogoiThemeMode.sepia => _base(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF8D6E63),
              surface: const Color(0xFFF4ECD8),
            ),
          ),
      };

  static ThemeData _base(ColorScheme scheme) => ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        visualDensity: VisualDensity.compact,
        dividerTheme: DividerThemeData(
          color: scheme.outlineVariant,
          space: 1,
          thickness: 1,
        ),
        cardTheme: const CardThemeData(
          elevation: 1,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
        ),
      );
}
