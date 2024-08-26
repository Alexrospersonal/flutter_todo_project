import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class PriorityButton extends StatelessWidget {
  const PriorityButton({super.key});

  get providerContext => null;

  @override
  Widget build(BuildContext context) {
    return Selector<TaskNotifier, bool>(
      selector: (context, taskNotifier) => taskNotifier.important,
      builder: (context, isImportant, child) {
        return Flexible(
          flex: 1,
          child: SizedBox(
            height: 32,
            child: ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero)),
              onPressed: () => context.read<TaskNotifier>().setImportant(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).important,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: isImportant ? starColor : greyColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
