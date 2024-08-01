import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/category/category_widget.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/daily_progress_bar.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/tasks_category_filters.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Column(
          children: [
            Container(margin: const EdgeInsets.symmetric(horizontal: 20), child: const DailyProgressBar()),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              height: 125,
              child: const CategoryList(),
            ),
            const TasksCategoryFilters()
          ],
        ),
      ),
    );
  }
}
