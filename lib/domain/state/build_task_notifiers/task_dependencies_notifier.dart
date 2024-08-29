import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_date_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';

class TaskDependencies {
  final TaskNotifier taskNotifier;
  final TaskDateNotifier taskDateNotifier;
  final TaskTimeNotifier taskTimeNotifier;
  final RepeatlyNotifier repeatlyNotifier;
  final LastDayOfRepeatNotifier lastDayOfRepeatNotifier;
  final RepeatInTimeNotifier repeatInTimeNotifier;

  TaskDependencies({
    required this.taskNotifier,
    required this.taskDateNotifier,
    required this.taskTimeNotifier,
    required this.repeatlyNotifier,
    required this.lastDayOfRepeatNotifier,
    required this.repeatInTimeNotifier,
  });
}
