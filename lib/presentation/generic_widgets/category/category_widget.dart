import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // CategoryManager categoryManager = CategoryManager.instance;
    var listOfCategories = ref.watch(listCategoryNotifierProvider.notifier).getCategories();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listOfCategories.length,
      itemBuilder: (context, index) {
        bool isSelected = _selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              var selectedCategory = ref.read(listCategoryNotifierProvider.notifier).getCategoryById(index);
              ref.read(selectedCategoryNotifierProvider.notifier).selectCategory(selectedCategory);
              // TODO: додати при виборі сортування завдань
              // var model = Provider.of<HomepageModel>(context, listen: false);
              // model.sortTasksByCategory(listOfCategories[index]);
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
