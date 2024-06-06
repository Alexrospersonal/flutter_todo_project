import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/category/category_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: CategoryList(),
          ),
        ],
      ),
    );
  }
}
