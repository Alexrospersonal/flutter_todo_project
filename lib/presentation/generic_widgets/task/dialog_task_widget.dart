import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

/// Create the dialog which contains form for createing a new task
class NewTaskDialogWidget extends StatelessWidget {
  final Category category;

  const NewTaskDialogWidget({super.key, required this.category});

  // TODO: в батька теж є SafeArea. Виправити це. Або тут або там.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskState(category: category),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Dialog(
              backgroundColor: Theme.of(context).cardColor.withOpacity(0.76),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(bigBorderRadius)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: const TaskForm()),
        ),
      ),
    );
  }
}
