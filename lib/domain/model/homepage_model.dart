import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/db.dart';
import 'package:flutter_todo_project/domain/utils/filters.dart';

class HomepageModel extends ChangeNotifier {
  void addTask(
      {required String name, required String description, Category? category}) {
    Task newTask = Task(
        id: db.length,
        name: name,
        description: description,
        category: category);

    db.add(newTask);
    notifyListeners();

    // sortTasksByCategory();
  }

  void sortTasksByCategory(Category category) {
    CategoryFilter.instance.currentCategory = category;
    notifyListeners();
  }

  // TODO: Виправити на позначеня як завершене і додати фільтри
  void removeTask(int id) {
    print("remove from Id: $id");
    db[id].done = true;
    notifyListeners();
  }
}
