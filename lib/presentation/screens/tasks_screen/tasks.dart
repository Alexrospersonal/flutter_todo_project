import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/category/category_widget.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/daily_progress_bar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: const Column(
          children: [
            DailyProgressBar(),
            SizedBox(
              height: 50,
              child: CategoryList(),
            ),
          ],
        ),
      ),
    );
  }
}
