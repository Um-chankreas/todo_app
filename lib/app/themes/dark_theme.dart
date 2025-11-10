import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/app_colors.dart';
import 'package:todo_app/app/themes/app_text_theme.dart';
import 'package:todo_app/main.dart';

final ThemeData darkTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: buildTextTheme(localize == "Kh" ? "KhmerFont" : "Poppins"),
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  switchTheme: SwitchThemeData(
    splashRadius: 0,
    thumbColor: WidgetStateProperty.all(Colors.white),
    trackOutlineColor: WidgetStateProperty.all(Colors.indigo),
    trackOutlineWidth: WidgetStateProperty.all(0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1F1F1F),
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigoAccent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigoAccent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.redAccent),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigoAccent),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.indigo,
    secondary: Colors.amber,
    surface: Color(0xFF1F1F1F),
    onSurface: Colors.white,
    error: AppColors.errorLight,
  ),
);
