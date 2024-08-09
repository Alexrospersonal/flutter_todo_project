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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskState(category: category),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Dialog(
            backgroundColor: Theme.of(context).cardColor.withOpacity(0.76),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(bigBorderRadius)),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: const TaskForm()),
      ),
    );
  }
}

class PageDialogTest extends StatefulWidget {
  const PageDialogTest({super.key});

  @override
  State<PageDialogTest> createState() => _PageDialogTestState();
}

class _PageDialogTestState extends State<PageDialogTest> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: 300,
      height: 500,
      color: Colors.grey,
      child: PageView(
        children: [
          Center(
            child: Text('First Page', style: textTheme.titleLarge),
          ),
          Center(
            child: Text('Second Page', style: textTheme.titleLarge),
          ),
          Center(
            child: Text('Third Page', style: textTheme.titleLarge),
          ),
        ],
      ),
    );
  }
}
