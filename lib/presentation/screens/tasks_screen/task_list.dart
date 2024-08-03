import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

// TODO: Доробити видалення і підтвреджеття. Тобто свайп в ліво це одне а свайп в право інша дія.
// TODO: детально розібратись з SnackBar та AnimatedList
class _TaskListWidgetState extends State<TaskListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<TaskListItemData> tasks = [
    buildTask("Піти до качалочки", [true, true, true, true, true, true, false], true, null),
    buildTask("Постірати труси після присідання", [false, true, true, true, true, true, true], true, Colors.amber),
    buildTask("Урок з англійської", [true, true, true, true, true, true, true], false, null),
    buildTask("Купити пончик", [false, false, true, true, false, true, false], false, Colors.blueAccent),
    buildTask("Звільнити бродягу", [false, true, false, false, false, true, false], true, Colors.greenAccent),
    buildTask("Подзвонити мамі", [false, true, true, false, true, true, false], true, Colors.redAccent),
    buildTask("Пограти з Олегом", [false, false, false, false, false, true, false], false, null),
  ];
  TaskListItemData? _recentlyRemovedItem;
  int? _recentlyRemovedItemIndex;

  void removeIndex(int index) {
    final removedItem = tasks[index];
    setState(() {
      _recentlyRemovedItem = removedItem;
      _recentlyRemovedItemIndex = index;
      tasks.removeAt(index);
    });

    final snackBar = SnackBar(
      content: Text('Item removed'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => _undoRemove(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: TaskListItem(
          id: index,
          taskData: removedItem,
          onDismissed: () {},
        ),
      ),
    );
  }

  void _undoRemove() {
    if (_recentlyRemovedItem != null && _recentlyRemovedItemIndex != null) {
      setState(() {
        tasks.insert(_recentlyRemovedItemIndex!, _recentlyRemovedItem!);
        _listKey.currentState?.insertItem(_recentlyRemovedItemIndex!);
      });

      _recentlyRemovedItem = null;
      _recentlyRemovedItemIndex = null;
    }
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
