import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/homepage_model.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';
import 'package:flutter_todo_project/data/services/category_manager.dart';
import 'package:flutter_todo_project/settings.dart';
import 'package:provider/provider.dart';

void main() async {
  CategoryManager.instance.addItems(namesOfCaterories);

  WidgetsFlutterBinding.ensureInitialized();
  DbService.initialize();
  runApp(ChangeNotifierProvider(
    create: (context) => HomepageModel(),
    child: const MainApp(),
  ));
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
      home: const HomePage());
  }
}
