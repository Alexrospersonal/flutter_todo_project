import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

// final taskStreamProvier = StreamProvider<List<TaskEntity>>((ref) {
//   // TODO: тут логіка отрмання, можна винести в окремий клас.
//   //Залежна від інших станів таких як категорія та фільтер.
//   //Тобто при зміні їх і оновлюється цей стан. МОжливо придумати кешування даних.
//   // Отривувані дані формувати в TaskListItemData

//   // Отримати звичайні завдання

//   // TODO: додпти код з документа, виправити цю всю жалість

final taskStreamProvider = StreamProvider<List<TaskListItemData>>((ref) {
  final repeatedTaskStream = DbService.db.repeatedTaskEntitys
      .filter()
      .isFinishedEqualTo(false)
      .watch(fireImmediately: true)
      .asBroadcastStream();

  final taskStream = DbService.db.taskEntitys
      .filter()
      // .category((q) => q.idEqualTo(categoryId))
      .isFinishedEqualTo(false)
      .hasRepeatsEqualTo(false)
      .watch(fireImmediately: true)
      .asBroadcastStream();

  return Rx.combineLatest2<List<TaskEntity>, List<RepeatedTaskEntity>, List<TaskListItemData>>(
      taskStream, repeatedTaskStream, (taskStream, repeatedTaskStream) {
    List<TaskListItemData> combinedTasks = [];

    var taskEnities = taskStream.map((task) {
      var taskData = TaskListItemData(id: task.id, name: task.title);

      if (task.category.value != null) {
        taskData.category = task.category.value.toString();
      }

      if (task.color != null) {
        taskData.color = Color(task.color!);
      }

      if (task.taskDate != null) {
        taskData.date = task.taskDate;
      }

      return taskData;
    }).toList();

    var repeatedEntities = repeatedTaskStream.map((repeatedTask) {
      var task = repeatedTask.task.value!;

      var taskData = TaskListItemData(id: task.id, name: task.title);

      if (task.category.value != null) {
        taskData.category = task.category.value.toString();
      }

      if (task.color != null) {
        taskData.color = Color(task.color!);
      }

      if (task.taskDate != null) {
        taskData.date = task.taskDate;
      }

      return taskData;
    }).toList();

    combinedTasks.addAll(taskEnities);
    combinedTasks.addAll(repeatedEntities);

    combinedTasks.sort((a, b) => a.name.compareTo(b.name));

    return combinedTasks;
  });
});
