import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/state/lang_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbService.initialize();
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Locale currentLocale = ref.watch(localeProvider);
    
    return MaterialApp(
      title: "Планюсик",
      localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: currentLocale, // uk - Ukrainian lang
      theme: lightTheme,

      // home: const HomePage()
      // TODO: Testing timepicker
      home: const TimePickerTest()
      );
  }
}


class TimePickerTest extends ConsumerStatefulWidget {
  const TimePickerTest({super.key});

  @override
  _TimePickerTestState createState() => _TimePickerTestState();
}

class _TimePickerTestState extends ConsumerState<TimePickerTest> {
  // Це функція відповідає за зміну мови на початку запуску додатка
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final systemLocale = View.of(context).platformDispatcher.locale;
      ref.read(localeProvider.notifier).state = systemLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Locale newLocale = locale.languageCode == 'en' ? const Locale('uk') : const Locale('en');
                ref.read(localeProvider.notifier).state = newLocale;
              },
              child: Text(S.of(context).langName)
            ),
            Container(
              width: 350,
              height: 195,
              padding: const EdgeInsets.all(cardPadding),
              decoration: outerCardStyle,
              child: NestedTimePicker(
                title: S.of(context).selectNotificationTime,
                initialDate: DateTime.now(),
                getTime: (TimeOfDay? time) {
                  if (time != null) {
                    // print("Time: $time");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}