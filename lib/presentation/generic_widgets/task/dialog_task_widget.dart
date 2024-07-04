import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:provider/provider.dart';

/// Create the dialog which contains form for createing a new task
class NewTaskDialogWidget extends StatelessWidget {
  final Category category;

  const NewTaskDialogWidget({
    super.key,
    required this.category
  });
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskState(category: category),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: const TaskForm()
        ),
      ),
    );
  }
}

