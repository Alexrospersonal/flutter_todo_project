import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(238, 240, 242, 1),
    onPrimary: Color.fromRGBO(53, 53, 53, 1),
    secondary: Color.fromRGBO(47, 215, 184, 1),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Color.fromRGBO(53, 53, 53, 1),
    surface: Color.fromRGBO(238, 240, 242, 1),
    onSurface: Color.fromRGBO(53, 53, 53, 1)
  ),
  iconTheme:const IconThemeData(
    color: Color.fromRGBO(60, 60, 60, 1)
  ),
  // textTheme: TextTheme(
    
  // )
);

// colors

