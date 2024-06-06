import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/model/homepage_model.dart';
import 'package:flutter_todo_project/data/services/category_manager.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    CategoryManager categoryManager = CategoryManager.instance;
    var listOfCategories = categoryManager.getItems();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listOfCategories.length,
      itemBuilder: (context, index) {
        bool isSelected = _selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              var model = Provider.of<HomepageModel>(context, listen: false);
              model.sortTasksByCategory(listOfCategories[index]);
            });
          },
          child: Container(
            // width: 100,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
                color:
                    isSelected ? Colors.blue.withOpacity(0.2) : Colors.white),
            child: Center(
              child: Text(
                "${listOfCategories[index]}",
                style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
        );
      },
    );
  }
}
