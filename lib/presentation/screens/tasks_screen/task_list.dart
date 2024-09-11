import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/contollers/task_list_controller.dart';
import 'package:flutter_todo_project/domain/entities/finished_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/task_stream_provider.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListWidget extends ConsumerStatefulWidget {
  const TaskListWidget({super.key});

  @override
  ConsumerState<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends ConsumerState<TaskListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Queue<SnackItemData> queue = Queue<SnackItemData>();

  List<TaskListItemData> tasks = [];

  void removeIndex(int index, bool isDelete) {
    // TODO: відносно isDelete зробити логіку або завершення або видалення
    final removedTask = tasks[index];
    queue.addLast(SnackItemData(id: index, isFinished: false, task: removedTask));
    tasks.removeAt(index);

    final snackBar = SnackBar(
      content: Text(S.of(context).UndoLastAction),
      action: SnackBarAction(
        label: S.of(context).cancel,
        onPressed: () => _undoRemove(),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((reason) async {
      // TODO: винести в окремий клас який і провіряє завдання і кладе їх у завершенні завдання
      if (reason != SnackBarClosedReason.action) {
        if (isDelete) {
          await DbService.db.writeTxn(() async {
            await DbService.db.taskEntitys.delete(removedTask.id);
          });
        } else {
          await DbService.db.writeTxn(() async {
            final task = await DbService.db.taskEntitys.get(removedTask.id);
            task?.isFinished = true;
            await DbService.db.taskEntitys.put(task!);

            var finishedTask = FinishedTaskEntity(finishedDate: DateTime.now());
            finishedTask.task.value = task;

            await DbService.db.finishedTaskEntitys.put(finishedTask);
            finishedTask.task.save();
          });
        }
      }
    });
    _listKey.currentState?.removeItem(index, (context, animation) => const SizedBox.shrink());
  }

  void _undoRemove() {
    SnackItemData removedTask = queue.removeLast();

    tasks.insert(removedTask.id, removedTask.task);
    _listKey.currentState?.insertItem(removedTask.id);
  }

  // TODO: додати видалення і повернення до списку. Тобто його видаляти повертати і завершувати
  // це все має оновлювати список
  // Виправити помилку яке стається
  @override
  Widget build(BuildContext context) {
    final taskListAsync = ref.watch(taskStreamProvier);

    return taskListAsync.when(
      data: (tasksEntity) {
        var newTasks = converter(tasksEntity);
        updateList(newTasks);

        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: AnimatedList(
              key: _listKey,
              initialItemCount: tasks.length,
              itemBuilder: (context, index, animation) {
                return TaskListItem(
                    id: index, taskData: tasks[index], onDismissed: (bool delete) => removeIndex(index, delete));
              },
            ));
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }

  // TODO: написати нормальну логіку або отримання конвертованих даних із стану
  List<TaskListItemData> converter(List<TaskEntity> tasksEntity) {
    return tasksEntity.map<TaskListItemData>((taskEntity) {
      var taskItem = TaskListItemData(id: taskEntity.id, name: taskEntity.title);
      taskEntity.category.load();
      taskItem.category = taskEntity.category.toString();

      if (taskEntity.color != null) {
        taskItem.color = Color(taskEntity.color!);
      }

      if (taskEntity.taskDate != null) {
        taskItem.addDate(taskEntity.taskDate);
      }

      return taskItem;
    }).toList();
  }

  void updateList(List<TaskListItemData> newTasks) {
    tasks = TaskListController(listKey: _listKey, tasks: tasks).updateList(newTasks);

    // if (tasks.isEmpty) {
    //   tasks = List.from(newTasks);
    //   for (var i = 0; i < newTasks.length; i++) {
    //     _listKey.currentState?.insertItem(i);
    //   }
    // } else if (tasks.length == newTasks.length) {
    //   for (var i = tasks.length - 1; i >= 0; i--) {
    //     final removedTask = tasks.removeAt(i);
    //     _listKey.currentState?.removeItem(i, (context, animation) {
    //       return TaskListItem(id: removedTask.id, taskData: removedTask, onDismissed: (bool delete) {});
    //     });
    //   }
    //   tasks = List.from(newTasks);
    //   for (var i = 0; i < tasks.length; i++) {
    //     _listKey.currentState?.insertItem(i);
    //   }
    // } else {
    //   final initialLength = tasks.length;
    //   tasks = List.from(newTasks);
    //   _listKey.currentState?.insertItem(initialLength);
    // }
  }
}

class SnackItemData {
  final int id;
  final bool isFinished;
  final TaskListItemData task;

  const SnackItemData({required this.id, required this.isFinished, required this.task});
}
