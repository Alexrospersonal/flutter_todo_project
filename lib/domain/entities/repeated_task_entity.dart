import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';

part 'repeated_task_entity.g.dart';

@collection
class RepeatedTaskEntity {
  Id id = Isar.autoIncrement;

  final IsarLink<TaskEntity> task = IsarLink<TaskEntity>();

  List<bool>? repeatDuringWeek;

  @Index()
  DateTime? endDateOfRepeatedly;

  List<DateTime?>? repeatDuringDay;

  bool isFinished = false;
}
