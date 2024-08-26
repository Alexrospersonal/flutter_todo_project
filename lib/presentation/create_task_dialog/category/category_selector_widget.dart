import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_creator_widget.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class CategorySelectorWidget extends ConsumerStatefulWidget {
  const CategorySelectorWidget({super.key});

  @override
  ConsumerState<CategorySelectorWidget> createState() =>
      _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState
    extends ConsumerState<CategorySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    BuildContext providerContext = context;

    List<Category> categoryList = ref.watch(listCategoryNotifierProvider);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Selector<TaskNotifier, Category>(
        selector: (context, taskNotifier) => taskNotifier.category,
        builder: (context, category, child) {
          return Expanded(
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
                      value: category,
                      items:
                          categoryList.map<DropdownMenuItem<Category>>((cat) {
                        return DropdownMenuItem(
                            value: cat,
                            child: Text(cat.name,
                                overflow: TextOverflow.ellipsis));
                      }).toList(),
                      onChanged: (newCategory) {
                        context.read<TaskNotifier>().setCategory(newCategory!);
                      }),
                ),
              ),
            ),
          );
        },
      ),
      const SizedBox(
        width: 10,
      ),
      // Invoke a new category dialog window.
      Expanded(
        child: SizedBox(
          height: 32,
          child: ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero)),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.white.withOpacity(0),
                  builder: (BuildContext context) {
                    return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: CategoryCreatorWidget(context: providerContext));
                  },
                );
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
