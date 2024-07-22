import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/repository/settings/settings_repository.dart';
import 'package:flutter_todo_project/domain/repository/settings/settings_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeNotifier extends StateNotifier<ThemeMode> {
//   ThemeNotifier(super.state);
// }

// final themeNotifierProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// final themeNotifierProvider = ThemeNotifierProviderBuilder.buildNotifierProvider();

// class ThemeNotifierProviderBuilder {
//   static SettingsRepositoryInterface? repository;

//   static StateProvider<ThemeMode> buildNotifierProvider() {
//     if (repository == null) {
//       throw const FormatException("Repository not initialized");
//     }
//     bool res = repository!.isDarkThemeSelected();
//     ThemeMode mode = res ? ThemeMode.dark : ThemeMode.light;
//     return StateProvider<ThemeMode>((ref) => mode);
//   }

//   static void setDarkThemeSelected(bool selected, WidgetRef ref) async {
//     if (repository == null) {
//       throw const FormatException("Repository not initialized");
//     }
//     var stateController = ref.read(themeNotifierProvider.notifier);
//     await repository!.setDarkThemeSelected(selected);
//     stateController.state = selected ? ThemeMode.dark : ThemeMode.light;
//   }
// }


// ----------------

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

// class 

final settingsNotifierProvider = AsyncNotifierProvider<SettingsNotifier, SettingsData>(
  () => SettingsNotifier()
);