import 'dart:ui';

import 'package:flutter_todo_project/domain/repository/settings/settings_repository_interface.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  final SharedPreferences preferences;

  SettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';
  static const _locale = "locale";

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }

  @override
  Locale getLocaleSelected() {
    String? localeName = preferences.getString(_locale);

    if (localeName != null) {
      return Locale(localeName);
    }

    return Locale(Intl.systemLocale);
  }

  @override
  Future<void> setLocale(String locale) async {
    await preferences.setString(_locale, locale);
  }
}
