import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/app_colors.dart';
import 'package:todo_app/app/themes/app_text_theme.dart';
import 'package:todo_app/main.dart';

final ThemeData lightTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.white,
  textTheme: buildTextTheme(localize == "Kh" ? "KhmerFont" : "Poppins"),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  switchTheme: SwitchThemeData(
    splashRadius: 0,
    thumbColor: WidgetStateProperty.all(Colors.white),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.indigoAccent;
      }
      return Colors.grey.shade400;
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    trackOutlineWidth: WidgetStateProperty.all(0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigo),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigo),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.red),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.indigo),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.indigo,
    secondary: Colors.amber,
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black,
    error: AppColors.errorLight,
  ),
);
