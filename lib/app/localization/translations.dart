import 'dart:ui';

import 'package:get/get.dart';
import 'package:todo_app/app/localization/en_us.dart';
import 'package:todo_app/app/localization/kh_kh.dart';

class LocalizationService extends Translations {
  static const locale = Locale('en', 'US');

  static const fallbackLocale = Locale('km', 'KH');

  static final langs = ['English', 'Khmer'];

  static final locales = [const Locale('en', 'US'), const Locale('km', 'KH')];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'km_KH': kmKh};

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang)!;
    Get.updateLocale(locale);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
