import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/repository/settings/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  final ThemeMode isDarkTheme;
  final Locale locale;

  const SettingsData({
    required this.isDarkTheme,
    required this.locale
  });
}

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

final settingsRepositoryProvider = FutureProvider<SettingsRepository>((ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return SettingsRepository(preferences: sharedPreferences);
});

class SettingsNotifier extends AsyncNotifier<SettingsData> {
  @override
  FutureOr<SettingsData> build() async {
    SettingsRepository repository = await ref.watch(settingsRepositoryProvider.future);
    final isDarkTheme = repository.isDarkThemeSelected() ? ThemeMode.dark : ThemeMode.light;
    final locale = repository.getLocaleSelected();
    return SettingsData(isDarkTheme: isDarkTheme, locale: locale);
  }

  Future<void> toggleTheme() async {
    final currentMode = state.value!.isDarkTheme;
    final newMode = currentMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    // Update repository with the new theme mode
    final repository = await ref.watch(settingsRepositoryProvider.future);
    await repository.setDarkThemeSelected(newMode == ThemeMode.dark);

    // Update the state
    state = AsyncValue.data(SettingsData(
      isDarkTheme: newMode,
      locale: state.value!.locale)
    );
  }

  Future<void> setLocale(Locale localeCode) async {
    final repository = await ref.watch(settingsRepositoryProvider.future);
    await repository.setLocale(localeCode.languageCode);

    state = AsyncValue.data(SettingsData(
      isDarkTheme: state.value!.isDarkTheme,
      locale: localeCode
    ));
  }
}

final settingsNotifierProvider = AsyncNotifierProvider<SettingsNotifier, SettingsData>(
  () => SettingsNotifier()
);