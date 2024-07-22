import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/locale_state.dart';
import 'package:flutter_todo_project/domain/state/theme_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class SettingsWidget extends ConsumerStatefulWidget {
  const SettingsWidget({super.key});

  @override
  ConsumerState<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    // ThemeMode mode = ref.watch(themeNotifierProvider);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            SettingsData settings =  await ref.read(settingsNotifierProvider.future);
            Locale newLocale = settings.locale.languageCode == 'en' ? const Locale('uk') : const Locale('en');
            await ref.read(settingsNotifierProvider.notifier).setLocale(newLocale);
            // ref.read(localeProvider.notifier).state = newLocale;
          },
          child: Text(S.of(context).langName)
        ),
        ElevatedButton(
          onPressed: () async {
            await ref.read(settingsNotifierProvider.notifier).toggleTheme();
            // bool isDarkMode = mode == ThemeMode.light ? true : false;
            // ThemeNotifierProviderBuilder.setDarkThemeSelected(isDarkMode, ref);
            // ref.read(themeNotifierProvider.notifier).state = newMode;
          },
          child: const Text("Theme color")
        ),
      ]
    );
  }
}