import 'package:flutter_todo_project/services/category.dart';

List<Task> db = [];

typedef AddTaskCallback = void Function(
    {required String name, required String description, Category? category});

class Task {
  int id;
  String name;
  String description;
  Category? category;

  bool done = false;

  Task(
      {required this.id,
      required this.name,
      this.description = "",
      this.category});

  @override
  String toString() {
    return "$name";
  }
}
