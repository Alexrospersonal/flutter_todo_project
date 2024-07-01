import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:provider/provider.dart';

class PriorityButton extends StatelessWidget {
  const PriorityButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Selector<TaskState, bool>(
      selector:(context, taskState) => taskState.important,
      builder:(context, isImportant, child) {
        return GestureDetector(
          onTap: () {
            context.read<TaskState>().setImportant();
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Icon(Icons.star_sharp, color: isImportant ? Colors.amber : Colors.grey),
          ),
        );
      },
    );
  }
}
