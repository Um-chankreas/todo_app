import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

TextTheme buildTextTheme(String fontFamily) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      fontFamily: localize == "Kh" ? "KhmerFont" : "Poppins",
      fontFamilyFallback: const ['KhmerFont'],
    ),
  );
}
