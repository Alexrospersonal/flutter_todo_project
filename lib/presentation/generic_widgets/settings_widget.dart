import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/settings_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class SettingsWidget extends ConsumerStatefulWidget {
  const SettingsWidget({super.key});

  @override
  ConsumerState<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            SettingsData settings =  await ref.read(settingsNotifierProvider.future);
            Locale newLocale = settings.locale.languageCode == 'en' ? const Locale('uk') : const Locale('en');
            await ref.read(settingsNotifierProvider.notifier).setLocale(newLocale);
          },
          child: Text(S.of(context).langName)
        ),
        ElevatedButton(
          onPressed: () async {
            await ref.read(settingsNotifierProvider.notifier).toggleTheme();
          },
          child: const Text("Theme color")
        ),
      ]
    );
  }
}