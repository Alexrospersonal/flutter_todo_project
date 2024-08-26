import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_date_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

/// Create the dialog which contains form for createing a new task
class NewTaskDialogWidget extends StatelessWidget {
  final Category category;

  const NewTaskDialogWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TaskNotifier(category: category)),
        ChangeNotifierProxyProvider<TaskNotifier, TaskDateNotifier>(
            create: (context) => TaskDateNotifier(),
            update: (context, taskState, taskDateNotifier) =>
                taskDateNotifier!..update(taskState)),
        ChangeNotifierProxyProvider<TaskDateNotifier, TaskTimeNotifier>(
            create: (context) => TaskTimeNotifier(),
            update: (context, taskDateNotifier, taskTimeNotifier) =>
                taskTimeNotifier!..update(taskDateNotifier)),
        ChangeNotifierProxyProvider<TaskDateNotifier, RepeatlyNotifier>(
          create: (context) => RepeatlyNotifier(),
          update: (context, taskDateNotifier, repeatlyNotifier) =>
              repeatlyNotifier!..update(taskDateNotifier),
        ),
        ChangeNotifierProxyProvider<RepeatlyNotifier, LastDayOfRepeatNotifier>(
          create: (context) => LastDayOfRepeatNotifier(),
          update: (context, repeatlyNotifier, lastDayOfRepeatlyNotifier) =>
              lastDayOfRepeatlyNotifier!..update(repeatlyNotifier),
        ),
        ChangeNotifierProxyProvider<RepeatlyNotifier, RepeatInTimeNotifier>(
          create: (context) => RepeatInTimeNotifier(),
          update: (context, repeatlyNotifier, repeatInTimeNotifier) =>
              repeatInTimeNotifier!..update(repeatlyNotifier),
        ),
      ],
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
