import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // child: AnimatedList(),
      child: Dismissible(
        key: ValueKey<int>(0),
        direction: DismissDirection.startToEnd,
        child: TaskListItemContainer(
          data: buildTask(),
        ),
      ),
    );
  }
}

