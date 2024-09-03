import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_date_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';
import 'package:provider/provider.dart';

class TaskDependencies {
  final TaskNotifier taskNotifier;
  final TaskDateNotifier taskDateNotifier;
  final TaskTimeNotifier taskTimeNotifier;
  final RepeatlyNotifier repeatlyNotifier;
  final LastDayOfRepeatNotifier lastDayOfRepeatNotifier;
  final RepeatInTimeNotifier repeatInTimeNotifier;

  TaskDependencies._({
    required this.taskNotifier,
    required this.taskDateNotifier,
    required this.taskTimeNotifier,
    required this.repeatlyNotifier,
    required this.lastDayOfRepeatNotifier,
    required this.repeatInTimeNotifier,
  });

  factory TaskDependencies.fromContext(BuildContext context) {
    var taskNotifier = context.read<TaskNotifier>();
    var taskDateNotifier = context.read<TaskDateNotifier>();
    var taskTimeNotifier = context.read<TaskTimeNotifier>();
    var repeatlyNotifier = context.read<RepeatlyNotifier>();
    var lastDayOfRepeatNotifier = context.read<LastDayOfRepeatNotifier>();
    var repeatInTimeNotifier = context.read<RepeatInTimeNotifier>();

    return TaskDependencies._(
        taskNotifier: taskNotifier,
        taskDateNotifier: taskDateNotifier,
        taskTimeNotifier: taskTimeNotifier,
        repeatlyNotifier: repeatlyNotifier,
        lastDayOfRepeatNotifier: lastDayOfRepeatNotifier,
        repeatInTimeNotifier: repeatInTimeNotifier);
  }
}
