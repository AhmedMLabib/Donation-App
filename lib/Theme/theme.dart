import 'package:flutter/material.dart';

// Theme.of(context).colorScheme.secondary
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromRGBO(238, 241, 215, 1.0),
    primary: Color.fromRGBO(120, 191, 126, 1.0),
    secondary: Color.fromRGBO(175, 216, 156, 1.0),
    tertiary: Color.fromRGBO(86, 110, 78, 1.0),
    onPrimary: Color.fromRGBO(30, 41, 28, 1.0),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromRGBO(27, 30, 26, 1.0),
    primary: Color.fromRGBO(53, 87, 57, 1.0),
    secondary: Color.fromRGBO(118, 153, 110, 1.0),
    tertiary: Color.fromRGBO(52, 70, 46, 1.0),
    onPrimary: Color.fromRGBO(229, 255, 226, 1.0),
  ),
);
