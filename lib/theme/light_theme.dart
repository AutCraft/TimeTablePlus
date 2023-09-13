import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  iconTheme: IconThemeData(
    color: Colors.black87
  ),
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(244, 243, 243, 1),
    primary: Colors.white,
    primaryContainer: Color(0xfffcf9f5),
    secondary: Colors.grey,
    secondaryContainer: Colors.grey.shade100,
    shadow: Colors.black,
    tertiary: Colors.grey[600]!,
    tertiaryContainer: Colors.black38,
    scrim: Colors.black54,
    surfaceVariant: Color(0xff2F50F3),
  ),
);