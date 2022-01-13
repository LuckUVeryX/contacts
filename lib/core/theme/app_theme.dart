import 'package:flutter/material.dart';

import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.from(
      colorScheme: const ColorScheme(
        primary: Palette.highlight,
        primaryVariant: Palette.highlight,
        secondary: Palette.tertiary,
        secondaryVariant: Palette.tertiary,
        surface: Palette.background,
        background: Palette.background,
        error: Palette.tertiary,
        onPrimary: Palette.buttonText,
        onSecondary: Palette.background,
        onSurface: Palette.paragraph,
        onBackground: Palette.background,
        onError: Palette.background,
        brightness: Brightness.light,
      ),
    );
  }
}
