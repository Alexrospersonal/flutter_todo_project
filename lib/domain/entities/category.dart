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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryEntity && other.id == id && other.name == name && other.emoji == emoji;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ emoji.hashCode;

  @override
  String toString() => "$emoji $name";
}
