import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/task_details_screen/task_details.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/dismissible_background.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_container.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:vibration/vibration.dart';

class TaskListItem extends StatefulWidget {
  final int id;
  final TaskListItemData taskData;
  final void Function() onDismissed;

  const TaskListItem(
      {super.key,
      required this.id,
      required this.taskData,
      required this.onDismissed});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(
              data: widget.taskData,
            ),
          )),
      child: Dismissible(
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
          if (direction == DismissDirection.startToEnd) {
            Vibration.vibrate(duration: 50, amplitude: 1);
          } else {
            Vibration.vibrate(duration: 100, amplitude: 32);
          }
          // Vibration.vibrate(pattern: [50,100,50], intensities: [1, 64]);
          widget.onDismissed();
        },
        child: TaskListItemContainer(
          data: widget.taskData,
        ),
      ),
    );
  }
}
