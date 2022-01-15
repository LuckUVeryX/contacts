import 'package:flutter/material.dart';

import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.from(
      colorScheme: const ColorScheme(
        primary: Palette.accent,
        primaryVariant: Palette.accent,
        secondary: Palette.accent,
        secondaryVariant: Palette.accent,
        surface: Palette.background,
        background: Palette.background,
        error: Colors.red,
        onPrimary: Palette.background,
        onSecondary: Palette.background,
        onSurface: Palette.headline,
        onBackground: Palette.paragraph,
        onError: Palette.accent,
        brightness: Brightness.dark,
      ),
    );
  }
}
