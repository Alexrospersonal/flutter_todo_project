import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbService.initialize();
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Планюсик",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 255, 136))
      ),
      // home: const HomePage()

      // TODO: Testing timepicker
      home: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Center(
          child: NestedTimePicker(
          initialDate: DateTime.now(),
          getTime: (TimeOfDay? time) {},
          title: "налаштування часу",
          ),
        ),
      )
      );
  }
}
