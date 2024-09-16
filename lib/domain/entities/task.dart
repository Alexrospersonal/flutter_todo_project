import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/overdue_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class TaskEntity {
  Id id = Isar.autoIncrement;

  String title;

  bool important = false;

  final IsarLink<CategoryEntity> category = IsarLink<CategoryEntity>();

  @Backlink(to: 'task')
  final repeatedTask = IsarLinks<RepeatedTaskEntity>();

  @Backlink(to: 'task')
  final overdueTask = IsarLinks<OverdueTaskEntity>();

  String? notate;

  @Index()
  DateTime? taskDate;

  bool hasTime = false;

  int? color;

  bool hasRepeats = false;

  bool isFinished = false;

  TaskEntity({required this.title});
}

// @embedded
// class TaskEntityDateTimeData {
//   DateTime? taskDate;
//   bool isTime = false;

//   bool isRepeatedly = false;
//   List<bool>? repeatDuringWeek;
//   DateTime? endDateOfRepeadetly;
//   List<DateTime?>? repeatDuringDay;
// }
