import 'package:flutter/material.dart';
import 'package:todo_app/app/themes/dark_theme.dart';
import 'package:todo_app/app/themes/light_theme.dart';

class AppTheme {
  static ThemeData getLightTheme() => lightTheme;
  static ThemeData getDarkTheme() => darkTheme;
}
