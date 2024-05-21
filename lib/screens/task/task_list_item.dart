import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_model.dart';
import 'package:flutter_todo_project/services/db.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatefulWidget {
  final Task task;
  final int id;

  const TaskListItem({super.key, required this.task, required this.id});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageModel>(
      builder: (context, value, child) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });

              if (isChecked) {
                final model = context.read<HomepageModel>();
                model.removeTask(widget.id);
              }
            },
          ),
          title: Text(widget.task.name),
          subtitle: Text(widget.task.description),
        ),
      ),
    );
  }
}
