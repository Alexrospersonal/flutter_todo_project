import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
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
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).canvasColor,
              // borderRadius: BorderRadius.circular(35),
            ),
            child: Icon(Icons.star_rounded, color: isImportant ? starColor : greyColor, size: 24,),
          ),
        );
      },
    );
  }
}
