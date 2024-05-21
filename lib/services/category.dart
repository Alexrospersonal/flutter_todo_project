import 'package:flutter_todo_project/services/manager_item.dart';

class Category extends ManagerItem {
  Category({required super.id, required super.name});

  @override
  String toString() {
    return "$name";
  }
}
