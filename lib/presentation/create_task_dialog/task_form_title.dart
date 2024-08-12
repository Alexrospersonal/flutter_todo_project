
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';

class TaskFormTitleWidget extends ConsumerWidget {
  final String title;

  const TaskFormTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            InkWell(
              onTap: () {
                ref.read(initialTaskDialogExpandedProvider.notifier).state =
                    false;
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 12.0,
                height: 12.0,
                child: Center(child: Icon(Icons.close, size: 16.0)),
              ),
            ),
          ]),
    );
  }
}