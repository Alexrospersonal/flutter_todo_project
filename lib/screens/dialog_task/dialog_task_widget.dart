import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/dialog_task/dialog_task_form.dart';

/// Class for dialog menu widget,
/// create dialog window with the new task form.
class AddNewTaskDialog extends StatelessWidget {
  const AddNewTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Center(
        child: Text('-Створити нове завдання-'),
      ),
      backgroundColor: Colors.white.withOpacity(0.1),
      alignment: Alignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(25.0),
          child: NewTaskForm(),
        )
      ],
    );
  }
}
