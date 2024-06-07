import 'package:flutter/material.dart';

class FlutterFridgeTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 117, 208, 247),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 19, 185, 255),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 16, 46, 59),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 19, 185, 255),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
