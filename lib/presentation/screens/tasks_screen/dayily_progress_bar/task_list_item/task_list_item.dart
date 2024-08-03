import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/dismissible_background.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_container.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListItem extends StatefulWidget {
  final int id;
  final TaskListItemData taskData;
  final void Function() onDismissed;

  const TaskListItem({
    super.key,
    required this.id,
    required this.taskData,
    required this.onDismissed
  });

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(widget.id),
      // direction: DismissDirection.startToEnd,
      background: DismissedBackground(
        color: Theme.of(context).colorScheme.primary,
        icon: Icons.check,
        aligment: Alignment.centerLeft,
      ),
      secondaryBackground: DismissedBackground(
        color: Theme.of(context).colorScheme.error,
        icon: Icons.delete,
        aligment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        widget.onDismissed();
      },
      child: TaskListItemContainer(
        data: widget.taskData,
      ),
    );
  }
}
