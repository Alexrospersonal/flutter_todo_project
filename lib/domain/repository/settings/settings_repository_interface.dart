import 'package:flutter/material.dart';

abstract interface class SettingsRepositoryInterface {
  bool isDarkThemeSelected();
  Locale getLocaleSelected();
  Future<void> setDarkThemeSelected(bool selected);
  Future<void> setLocale(String locale);
}