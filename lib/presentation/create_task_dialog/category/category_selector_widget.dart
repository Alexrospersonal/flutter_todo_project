import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_creator_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class CategorySelectorWidget extends ConsumerStatefulWidget {
  const CategorySelectorWidget({super.key});

  @override
  ConsumerState<CategorySelectorWidget> createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends ConsumerState<CategorySelectorWidget> {
  CategoryEntity? selectedCategory;

  void Function(int) getUpdateTaskCategory(BuildContext parentContext) {
    return (int id) {
      var createdCategory = DbService.db.categoryEntitys.getSync(id);
      parentContext.read<TaskNotifier>().setCategory(createdCategory!);
    };
  }

  @override
  void initState() {
    super.initState();
    var id = ref.read(selectedCategoryId.notifier).state;
    selectedCategory = DbService.db.categoryEntitys.getSync(id);
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategory != null && context.read<TaskNotifier>().category == null) {
      context.read<TaskNotifier>().category = selectedCategory;
    }

    selectedCategory ??= context.watch<TaskNotifier>().category;
    var updateTaskCategory = getUpdateTaskCategory(context);
    var categoryList = DbService.db.categoryEntitys.filter().not().nameEqualTo("#01").findAllSync();

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 32,
            // width: 160,
            padding: const EdgeInsets.fromLTRB(10, 1.5, 10, 1.5),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(smallBorderRadius),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  elevation: 10,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(mediumBorderRadius),
                  hint: const Text("Choose category"),
                  style: Theme.of(context).textTheme.bodyMedium,
                  value: selectedCategory,
                  items: categoryList.map<DropdownMenuItem<CategoryEntity>>((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat.name, overflow: TextOverflow.ellipsis));
                  }).toList(),
                  onChanged: (CategoryEntity? category) {
                    context.read<TaskNotifier>().setCategory(category!);
                  }),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: SizedBox(
          height: 32,
          child: ElevatedButton(
              style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.white.withOpacity(0),
                  builder: (BuildContext context) {
                    return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: CategoryCreatorWidget(getCreatedCategoryId: updateTaskCategory, context: context));
                  },
                );
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  S.of(context).addNewList,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Icon(
                  Icons.add,
                  size: 12,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ])),
        ),
      ),
    ]);
  }
}
