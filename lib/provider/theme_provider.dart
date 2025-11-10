import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/app_key.dart';
import 'package:todo_app/app/utils/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    AppLog.success(_themeMode.name);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppKey.themeMode, isOn);
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(AppKey.themeMode);
    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppKey.themeMode, mode == ThemeMode.dark);
    notifyListeners();
  }
}
