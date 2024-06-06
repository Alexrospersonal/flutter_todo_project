import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/db.dart';

class CategoryFilter {
  Category? currentCategory;

  CategoryFilter._privateConstructor();

  static final CategoryFilter _instance = CategoryFilter._privateConstructor();

  static CategoryFilter get instance => _instance;

  List<Task> getSortedList() {
    if (currentCategory != null && currentCategory!.id != 0) {
      return db.where((task) {
        if (task.done != true && task.category != null) {
          return task.category!.id == currentCategory!.id;
        }
        return false;
      }).toList();
    }

    return db.where((task) => task.done == false).toList();
  }
}
