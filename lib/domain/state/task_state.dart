import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/category_manager.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

class TaskState extends ChangeNotifier {
  String title = "";
  String? note;
  // TODO: Category при створенні має обиртати по замовчуванню із стану глобального який має бути написаний на Riverpod;
  Category category = CategoryManager.instance.getItem(0);
  Color color = taskColors[0];
  bool important = false;

  bool hasDate = false;
  bool hasTime = false;
  DateTime? taskDateTime;

  bool recurring = false;
  List<bool> recurringDays = List.generate(7, (index) => false);
  DateTime? recurringEndDate;

  bool hasDuration = false;
  DateTime? taskDuration;
  bool notifyAboutTheEndOfTheTask = false;

  Set<DateTime> notification = <DateTime>{};

  void setImportant() {
    important = !important;
    notifyListeners();
  }

  void setColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    category = newCategory;
    notifyListeners();
  }
}