import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.lightGreen,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
    ),
  );
}
