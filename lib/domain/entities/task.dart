import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class TaskEntity {
  Id id = Isar.autoIncrement;

  String title;

  bool important = false;

  final IsarLink<CategoryEntity> category = IsarLink<CategoryEntity>();

  String? notate;

  DateTime? taskDate;

  TaskEntity({required this.title});
}
