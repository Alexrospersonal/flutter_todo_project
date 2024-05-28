import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_model.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_controller.dart';
import 'package:flutter_todo_project/services/category_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomepageModel(),
    child: const MainApp(),
  ));

  CategoryManager categoryManager = CategoryManager.instance;

  categoryManager.addItem("All");
  categoryManager.addItem("Home");
  categoryManager.addItem("GYM");
  categoryManager.addItem("Work");
  categoryManager.addItem("Morning routine");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // locale: Locale('uk', 'UA'),
        // supportedLocales: [
        //   Locale('en', 'US'),
        //   Locale('uk', 'UA'),
        // ],
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        home: HomePage());
  }
}
