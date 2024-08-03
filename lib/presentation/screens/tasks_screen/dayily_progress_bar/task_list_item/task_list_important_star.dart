import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskListImportantStar extends StatelessWidget {
  const TaskListImportantStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -20,
      top: 32 - 16,
      child: Container(
        height: 16,
        width: 16,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).canvasColor),
        alignment: Alignment.center,
        child: const Icon(
          Icons.star_rounded,
          color: starColor,
          size: 12,
        ),
      ),
    );
  }
}
