import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';

part 'finished_task_entity.g.dart';

@collection
class FinishedTaskEntity {
  Id id = Isar.autoIncrement;

  final IsarLink<TaskEntity> task = IsarLink<TaskEntity>();

  @Index()
  DateTime finishedDate;

  FinishedTaskEntity({required this.finishedDate});
}
