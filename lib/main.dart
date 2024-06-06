import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/model/homepage_model.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';
import 'package:flutter_todo_project/data/services/category_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomepageModel(),
    child: const MainApp(),
  ));

  CategoryManager categoryManager = CategoryManager.instance;

  categoryManager.addItem("😍Несортоване");
  categoryManager.addItem("😄Home");
  categoryManager.addItem("😇GYM");
  categoryManager.addItem("😄Work");
  categoryManager.addItem("😊Morning routine");
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Планюсик",
      home: HomePage());
  }
}
