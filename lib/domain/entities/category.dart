import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class CategoryEntity {
  Id id = Isar.autoIncrement;
  String name;
  String emoji;

  @Backlink(to: 'category')
  final IsarLinks<TaskEntity> tasks = IsarLinks<TaskEntity>();

  CategoryEntity({required this.name, this.emoji = ""});
}
