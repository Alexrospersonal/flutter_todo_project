import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/builders/task_query_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/domain/state/selected_filter_state.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

final taskStreamProvider = StreamProvider<List<TaskListItemData>>((ref) {
  var categoryId = ref.watch(selectedCategoryId);
  var filter = ref.watch(selectedFilterIndexProvider);


  var builder = TaskQueryBuilder(categoryId: categoryId);
  var taskQuery = TaskQueryBuilderDirector(builder: builder).build(filter);

  var taskStream = taskQuery.watch(fireImmediately: true);

  return taskStream.map((taskStream) {
    return taskStream.map((task) {
      var taskData = buildTaskListItemData(task);
      return taskData;
    }).toList();
  });

  // final repeatedTaskStream = DbService.db.repeatedTaskEntitys
  //     .filter()
  //     .repeatDuringWeekIsNotNull()
  //     .and()
  //     .isFinishedEqualTo(false)
  //     .watch(fireImmediately: true)
  //     .asBroadcastStream();

  // return Rx.combineLatest2<List<TaskEntity>, List<RepeatedTaskEntity>,
  //         List<TaskListItemData>>(taskStream, repeatedTaskStream,
  //     (taskStream, repeatedTaskStream) {
  //   List<TaskListItemData> combinedTasks = [];

  //   var taskEnities = taskStream.map((task) {
  //     var taskData = buildTaskListItemData(task);
  //     return taskData;
  //   }).toList();

  //   var repeatedTaskController = RepeatedTaskController();
  //   var repeatedEntities =
  //       repeatedTaskController.getRepeatedTaskData(repeatedTaskStream);
  //   repeatedEntities =
  //       repeatedTaskController.sortByFilters(repeatedEntities, filter);

  //   combinedTasks.addAll(taskEnities);
  //   combinedTasks.addAll(repeatedEntities);

  //   // combinedTasks.sort((a, b) => a.name.compareTo(b.name));

  //   return combinedTasks;
  // });
});

// TODO: розширити функціонал
TaskListItemData buildTaskListItemData(TaskEntity task) {
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
}
