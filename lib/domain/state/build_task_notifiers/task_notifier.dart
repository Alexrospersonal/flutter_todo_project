import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/enabled_notifier_interface.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

class TaskNotifier extends ChangeNotifier implements IsEnabledNotifier {
  String title = "";
  String? note;
  Category category;
  Color color = taskColors[0];
  bool important = false;
  TaskNotifier({required this.category});

  @override
  bool canEnabled = true;

  @override
  bool isEnabled = true;

  @override
  void update<T extends IsEnabledNotifier>(T state) {}

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
