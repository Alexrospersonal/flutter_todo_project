import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

typedef ListKey = GlobalKey<AnimatedListState>;

class TaskListController {
  ListKey listKey;
  List<TaskListItemData> tasks;

  TaskListController({required this.listKey, required this.tasks});

  void insertAllTasksToAnimationState() {
    for (var i = 0; i < tasks.length; i++) {
      listKey.currentState?.insertItem(i);
    }
  }

  void removeAllTaskFromAnimationState() {
    for (var i = tasks.length - 1; i >= 0; i--) {
      tasks.removeAt(i);
      listKey.currentState?.removeItem(i, (context, animation) {
        return const SizedBox.shrink();
      });
    }
  }

  // TODO: баг з відображенням копій. Напвено не розраховано на додавання більше одного за раз
  List<TaskListItemData> updateList(List<TaskListItemData> newTasks) {
    if (tasks.isEmpty) {
      tasks = List.from(newTasks);
      insertAllTasksToAnimationState();
    } else if (tasks.length == newTasks.length) {
      removeAllTaskFromAnimationState();
      tasks = List.from(newTasks);
      insertAllTasksToAnimationState();
    } else {
      final initialLength = tasks.length;
      tasks = List.from(newTasks);
      listKey.currentState?.insertItem(initialLength);
    }
    return tasks;
  }
}
