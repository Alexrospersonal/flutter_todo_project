import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/add_time_to_list_button.dart';
import 'package:provider/provider.dart';

class RepeatInTimesList extends StatelessWidget {
  const RepeatInTimesList({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime?> times = context.watch<RepeatInTimeNotifier>().times;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              4,
              (int idx) => AddTimeToListButton(
                    index: idx,
                    time: times[idx],
                    callback: (time, idx) {
                      context
                          .read<RepeatInTimeNotifier>()
                          .setRepeatTime(time, idx);
                    },
                  ))),
    );
  }
}
