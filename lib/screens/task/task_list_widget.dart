import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/task/task_list_item.dart';
import 'package:flutter_todo_project/services/db.dart';
import 'package:flutter_todo_project/utils/filters.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks = CategoryFilter.instance.getSortedList();

  TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskListItem(task: tasks[index], id: tasks[index].id);
        });
  }
}
