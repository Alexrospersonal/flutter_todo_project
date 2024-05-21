import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/category/category_widget.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_model.dart';
import 'package:flutter_todo_project/screens/task/task_list_widget.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: CategoryList(),
          ),
          Expanded(
              child: Consumer<HomepageModel>(
                  builder: (context, value, child) => TasksList()))
        ],
      ),
    );
  }
}
