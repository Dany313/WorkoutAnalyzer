import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromRGBO(16, 0, 43, 1);
const COLOR_SECONDARY = Color.fromRGBO(36, 0, 70, 1);
const COLOR_ACCENT = Color.fromRGBO(224, 170, 255, 1);


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme:  const ColorScheme.dark(
    background: COLOR_PRIMARY,
    surface: COLOR_SECONDARY,
    onSurface: Colors.white

  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: COLOR_PRIMARY,

  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: COLOR_SECONDARY,
    foregroundColor: Colors.white

  ),
  textTheme: const TextTheme(

    labelSmall: TextStyle(
      fontSize: 14,
      color: COLOR_ACCENT,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 50
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  iconTheme: const IconThemeData(
    color: COLOR_ACCENT
  ),
);