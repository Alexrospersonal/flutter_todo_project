import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/contollers/task_finishing_controller.dart';
import 'package:flutter_todo_project/domain/contollers/task_list_controller.dart';
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

class _TaskListWidgetState extends ConsumerState<TaskListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Queue<SnackItemData> queue = Queue<SnackItemData>();

  late SnackBar snackBar;

  List<TaskListItemData> tasks = [];

  SnackBar getSnackBar() {
    return SnackBar(
      content: Text(S.of(context).UndoLastAction),
      duration: const Duration(milliseconds: 1000),
      action: SnackBarAction(
        label: S.of(context).cancel,
        onPressed: () => _undoRemove(),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  Future<void> removeAfterDialogWarning(int index, bool delete) async {
    var res = await getAlertDialogConfirmResult();

    if (res != null && res) {
      var controller = TaskFinishingController();
      await controller.handleTaskDeletionOrFinishingAfterSnackBar(
          true, tasks[index]);
    } else if (res != null && !res) {
      _undoRemove();
    }
  }

  void removeFromAnimatedList(int index, TaskListItemData removedTask) {
    queue.addLast(
        SnackItemData(id: index, isFinished: false, task: removedTask));

    tasks.removeAt(index);

    _listKey.currentState
        ?.removeItem(index, (context, animation) => const SizedBox.shrink());
  }

  Future<bool?> getAlertDialogConfirmResult() async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const WarningDialog();
        });
  }

  void removeAfterSnackBar(int index, bool isDelete) {
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((reason) async {
      var controller = TaskFinishingController();

      if (reason != SnackBarClosedReason.action) {
        await controller.handleTaskDeletionOrFinishingAfterSnackBar(
            isDelete, tasks[index]);
        await ref.read(categoriesProvider.notifier).loadCategories();
      }
    });
  }

  void _undoRemove() {
    SnackItemData removedTask = queue.removeLast();

    tasks.insert(removedTask.id, removedTask.task);
    _listKey.currentState?.insertItem(removedTask.id);
  }

  Future<void> removeTaskFromList(int index, bool delete) async {
    if (tasks[index].isCopy) {
      removeFromAnimatedList(index, tasks[index]);
      await removeAfterDialogWarning(index, delete);
    } else {
      removeFromAnimatedList(index, tasks[index]);
      removeAfterSnackBar(index, delete);
    }
  }

  void updateList(List<TaskListItemData> newTasks) {
    tasks = TaskListController(listKey: _listKey, tasks: tasks)
        .updateList(newTasks);
  }

  @override
  Widget build(BuildContext context) {
    snackBar = getSnackBar();
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
                  onDismissed: (isDelete) =>
                      removeTaskFromList(index, isDelete),
                );
              },
            ));
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class SnackItemData {
  final int id;
  final bool isFinished;
  final TaskListItemData task;

  const SnackItemData(
      {required this.id, required this.isFinished, required this.task});
}

class WarningDialog extends StatelessWidget {
  const WarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).deleteRepeatedTaskwarningTitle),
      content: Text(S.of(context).deleteRepeatedTaskwarningTitle),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(S.of(context).no),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(S.of(context).yes),
        ),
      ],
    );
  }
}
