import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Queue<SnackItemData> queue = Queue<SnackItemData>();

  List<TaskListItemData> tasks = [
    buildTask("Піти до качалочки", [true, true, true, true, true, true, false],
        true, null),
    buildTask("Постірати труси після присідання",
        [false, true, true, true, true, true, true], true, Colors.amber),
    buildTask("Урок з англійської", [true, true, true, true, true, true, true],
        false, null),
    buildTask("Купити пончик", [false, false, true, true, false, true, false],
        false, Colors.blueAccent),
    buildTask(
        "Звільнити бродягу",
        [false, true, false, false, false, true, false],
        true,
        Colors.greenAccent),
    buildTask("Подзвонити мамі", [false, true, true, false, true, true, false],
        true, Colors.redAccent),
    buildTask("Пограти з Олегом",
        [false, false, false, false, false, true, false], false, null),
  ];

  void removeIndex(int index) {
    final removedItem = tasks[index];
    setState(() {
      queue.addLast(
          SnackItemData(id: index, isFinished: false, task: removedItem));
      tasks.removeAt(index);
    });

    final snackBar = SnackBar(
      content: Text(S.of(context).UndoLastAction),
      action: SnackBarAction(
        label: S.of(context).cancel,
        onPressed: () => _undoRemove(),
      ),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _listKey.currentState
        ?.removeItem(index, (context, animation) => const SizedBox.shrink());
  }

  void _undoRemove() {
    SnackItemData removedTask = queue.removeLast();

    setState(() {
      tasks.insert(removedTask.id, removedTask.task);
      _listKey.currentState?.insertItem(removedTask.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedList(
          key: _listKey,
          initialItemCount: tasks.length,
          itemBuilder: (context, index, animation) {
            return TaskListItem(
                id: index,
                taskData: tasks[index],
                onDismissed: () => removeIndex(index));
          },
        )
        // child: TaskListItem(id:0, taskData: buildTask()),
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
