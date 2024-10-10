import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/builders/directors/filtered_task_query_director.dart';
import 'package:flutter_todo_project/domain/builders/task_list_item_data_builder.dart';
import 'package:flutter_todo_project/domain/builders/task_query_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/domain/state/selected_filter_state.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

final taskStreamProvider = StreamProvider<List<TaskListItemData>>((ref) {
  var categoryId = ref.watch(selectedCategoryId);
  var filter = ref.watch(selectedFilterIndexProvider);

  var builder = TaskQueryBuilder(categoryId: categoryId);
  var taskQuery = FilteredTaskQueryDirector(builder: builder).build(filter);

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

TaskListItemData buildTaskListItemData(TaskEntity task) {
  return TaskItemDataBuilder(task: task)
      .createTaskData()
      .addCategory()
      .addColor()
      .addDate()
      .addHasTime()
      .addIsOriginal()
      .addNotificationId()
      .addRepeatedData()
      .build();
}
