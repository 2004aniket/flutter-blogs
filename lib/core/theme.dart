import 'package:blog/core/color_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = color_pallete.backgroundColor]) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 3, color: color));

  static final DarkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: color_pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        border: _border(),
        enabledBorder: _border(color_pallete.borderColor),
        focusedBorder: _border(color_pallete.gradient2),
        errorBorder: _border(color_pallete.errorColor)),
  );
  static final LIghtTheme = ThemeData.light();
}
