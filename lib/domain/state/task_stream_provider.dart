import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/builders/task_query_builder.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/domain/state/selected_filter_state.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

//   // TODO: додпти код з документа, виправити цю всю жалість

final taskStreamProvider = StreamProvider<List<TaskListItemData>>((ref) {
  var categoryId = ref.watch(selectedCategoryId);
  var filter = ref.watch(selectedFilterIndexProvider);

  var builder = TaskQueryBuilder(categoryId: categoryId);
  var taskQuery = TaskQueryBuilderDirector(builder: builder).build(filter);

  var taskStream = taskQuery.watch(fireImmediately: true).asBroadcastStream();

  final repeatedTaskStream = DbService.db.repeatedTaskEntitys
      .filter()
      .repeatDuringWeekIsNotNull()
      .and()
      .isFinishedEqualTo(false)
      .watch(fireImmediately: true)
      .asBroadcastStream();

  return Rx.combineLatest2<List<TaskEntity>, List<RepeatedTaskEntity>,
          List<TaskListItemData>>(taskStream, repeatedTaskStream,
      (taskStream, repeatedTaskStream) {
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

    List<TaskListItemData> repeatedEntities = [];

    for (var i = 0; i < repeatedTaskStream.length; i++) {
      // TODO: додати логіку провірки повтору і якщо дні або години співпадають то стврювати)
    }

    // var repeatedEntities = repeatedTaskStream.map((repeatedTask) {
    //   var task = repeatedTask.task.value!;

    //   var taskData = TaskListItemData(id: task.id, name: task.title);

    //   if (task.category.value != null) {
    //     taskData.category = task.category.value.toString();
    //   }

    //   if (task.color != null) {
    //     taskData.color = Color(task.color!);
    //   }

    //   if (task.taskDate != null) {
    //     taskData.date = task.taskDate;
    //   }

    //   return taskData;
    // }).toList();

    combinedTasks.addAll(taskEnities);
    combinedTasks.addAll(repeatedEntities);

    // combinedTasks.sort((a, b) => a.name.compareTo(b.name));

    return combinedTasks;
  });
});
