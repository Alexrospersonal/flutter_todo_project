import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/category/category_creator_widget.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/category_manager.dart';
import 'package:provider/provider.dart';

class CategorySelectorWidget extends StatefulWidget {
  const CategorySelectorWidget({super.key});

  @override
  State<CategorySelectorWidget> createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  // Category selectedCategory = CategoryManager.instance.getItem(0);
  // final _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TaskState state = Provider.of<TaskState>(context, listen: false);
    BuildContext providerContext = context;

    List<Category> categoryList = CategoryManager.instance.getItems();

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Selector<TaskState, Category>(
        selector: (context, taskState) => taskState.category,
        builder: (context, category, child) {
          return Container(
            height: 35,
            padding: const EdgeInsets.fromLTRB(10, 1.5, 10, 1.5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(65),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  hint: const Text("Choose category"),
                  style: const TextStyle(color: Colors.black, fontSize: 13.0, fontFamily: 'Montserrat', overflow: TextOverflow.ellipsis),
                  value: category,
                  items: categoryList.map<DropdownMenuItem<Category>>((cat) {
                    return DropdownMenuItem(value: cat, child: SizedBox(
                      width: 80,
                      child: Text(cat.name, overflow: TextOverflow.ellipsis)));
                  }).toList(),
                  onChanged: (newCategory) {
                    context.read<TaskState>().setCategory(newCategory!);
                  }),
            ),
          );
        },
      ),
      

      // Invoke a new category dialog window.
      ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.white.withOpacity(0.5),
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: CategoryCreatorWidget(
                    context: providerContext
                  )
                );
              },
            );
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(0, 0)),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 10)),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
            elevation: MaterialStateProperty.all(0),
          ),
          child: const Row(children: [
            Icon(Icons.add),
            Text(
              "Новий список",
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'Montserrat',
                // fontWeight: FontWeight.w400
              ),
            )
          ])),
    ]);
  }
}