import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/services/notification_service.dart';
import 'package:flutter_todo_project/domain/state/settings_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await DbService.initialize();
  initializeTimeZones();
  // TODO: test adding categories
  List<CategoryEntity> categories = await DbService.db.categoryEntitys.where().findAll();
  if (categories.isEmpty) {
    final initialCategories = [
      CategoryEntity(name: 'Work', emoji: '💼'),
      CategoryEntity(name: 'Personal', emoji: '🏠'),
    ];

    await DbService.db.writeTxn(() async {
      await DbService.db.categoryEntitys.putAll(initialCategories);
    });
  }

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(child: MainApp(preferences: prefs)));
}

class MainApp extends ConsumerWidget {
  final SharedPreferences preferences;
  const MainApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsModeAsync = ref.watch(settingsNotifierProvider);

    return settingsModeAsync.when(
      data: (settings) {
        return MaterialApp(
            title: "Notifire",
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: settings.locale, // uk - Ukrainian lang
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: settings.isDarkTheme,
            // home: TimePickerTest());
            home: const HomePage());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Scaffold(
            body: Center(
          child: Text('Error: $error'),
        ));
      },
    );

    //   home: TimePickerTest()
  }
}

// class TimePickerTest extends ConsumerStatefulWidget {
//   const TimePickerTest({super.key});

//   @override
//   TimePickerTestState createState() => TimePickerTestState();
// }

// class TimePickerTestState extends ConsumerState<TimePickerTest> {
//   void getTimeFromTimePicker(TimeOfDay time) {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SettingsWidget(),
//             Container(
//                 width: 326,
//                 height: 200,
//                 padding: const EdgeInsets.all(cardPadding),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(bigBorderRadius), color: Theme.of(context).cardColor),
//                 child: NestedTimePicker(
//                   // title: S.of(context).selectNotificationTime,
//                   format12TimePicker: Inner12HourFormatPicker(
//                     initialDate: DateTime.now(),
//                     callback: getTimeFromTimePicker,
//                     enabled: false,
//                   ),
//                   format24TimePicker: Inner24HourFormatPicker(
//                     initialDate: DateTime.now(),
//                     callback: getTimeFromTimePicker,
//                     enabled: false,
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
