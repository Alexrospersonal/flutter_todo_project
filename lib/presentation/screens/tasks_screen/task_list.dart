import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/contollers/task_finishing_controller.dart';
import 'package:flutter_todo_project/domain/contollers/task_list_controller.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/domain/state/task_stream_provider.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListWidget extends ConsumerStatefulWidget {
  const TaskListWidget({super.key});

  @override
  ConsumerState<TaskListWidget> createState() => _TaskListWidgetState();
}

//TODO: Refactor
class _TaskListWidgetState extends ConsumerState<TaskListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Queue<SnackItemData> queue = Queue<SnackItemData>();

  List<TaskListItemData> tasks = [];

  void removeIndex(int index, bool isDelete) {
    final removedTask = tasks[index];
    queue.addLast(SnackItemData(id: index, isFinished: false, task: removedTask));
    tasks.removeAt(index);

    final snackBar = SnackBar(
      content: Text(S.of(context).UndoLastAction),
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: S.of(context).cancel,
        onPressed: () => _undoRemove(),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((reason) async {
      var controller = TaskFinishingController();

      // TODO: додати логіку завершення завдання
      //і якщо це останній повтор то його завершити
      //а якщо ні то стоврити наступну копію якщо її нема

      if (reason != SnackBarClosedReason.action) {
        if (isDelete) {
          await controller.removeTask(removedTask.id);
        } else {
          await DbService.db.writeTxn(() async {
            final task = await DbService.db.taskEntitys.get(removedTask.id);
            await controller.finishTask(removedTask.id, task);
            await controller.addTaskToFinishedTasks(task!);
          });
        }
        await ref.read(categoriesProvider.notifier).loadCategories();
      }
    });
    _listKey.currentState?.removeItem(index, (context, animation) => const SizedBox.shrink());
  }

  void _undoRemove() {
    SnackItemData removedTask = queue.removeLast();

    tasks.insert(removedTask.id, removedTask.task);
    _listKey.currentState?.insertItem(removedTask.id);
  }

  @override
  Widget build(BuildContext context) {
    final taskListAsync = ref.watch(taskStreamProvider);

    return taskListAsync.when(
      data: (tasksEntity) {
        updateList(tasksEntity);

        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: AnimatedList(
              key: _listKey,
              initialItemCount: tasks.length,
              itemBuilder: (context, index, animation) {
                return TaskListItem(
                    id: index,
                    taskData: tasks[index],
                    onDismissed: (bool delete) => removeIndex(index, delete));
              },
            ));
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }

  void updateList(List<TaskListItemData> newTasks) {
    tasks = TaskListController(listKey: _listKey, tasks: tasks).updateList(newTasks);
  }
}

class SnackItemData {
  final int id;
  final bool isFinished;
  final TaskListItemData task;

  const SnackItemData({required this.id, required this.isFinished, required this.task});
}
