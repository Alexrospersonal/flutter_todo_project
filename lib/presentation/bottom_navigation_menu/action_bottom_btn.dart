import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/dialog_task_widget.dart';

class CreateTaskBottomButton extends ConsumerWidget {
  const CreateTaskBottomButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Category cat = ref.watch(selectedCategoryNotifierProvider);

    return FloatingActionButton(
      onPressed: () => _showAddTaskDialog(context, cat),
      child: const Icon(Icons.add),
    );
  }

  void _showAddTaskDialog(BuildContext context, Category cat) {
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      barrierLabel: "Add Task",
      barrierColor: Colors.white.withOpacity(0.5),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
            child: ScaffoldMessenger(
              child: Builder(builder: (context) {
                return Scaffold(
                  body: NewTaskDialogWidget(category: cat),
                  backgroundColor: Colors.transparent,
                );
              }),
            ));
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }
}
