import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  iconTheme: IconThemeData(
    color: Colors.white70
  ),
  colorScheme: ColorScheme.dark(
    background: Color(0xFF2f3136),
    primary: Color(0xFF202225),
    primaryContainer: Color.fromARGB(255, 38, 41, 44),
    secondary: Colors.grey[100]!,
    secondaryContainer: Colors.grey[850]!,
    shadow: Colors.white,
    tertiary: Colors.grey[350]!,
    tertiaryContainer: Colors.white38,
    scrim: Colors.white54,
    surfaceVariant: Color(0xffbb86fc),
  ),
);