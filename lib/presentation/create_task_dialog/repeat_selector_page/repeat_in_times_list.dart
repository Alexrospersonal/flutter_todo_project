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
          children: List.generate(4 * 2 - 1, (int idx) {
            if (idx.isEven) {
              int itemIndex = idx ~/ 2;
              return AddTimeToListButton(
                  index: itemIndex,
                  time: times[itemIndex],
                  callback: (time, itemIndex) {
                    context
                        .read<RepeatInTimeNotifier>()
                        .setRepeatTime(time, itemIndex);
                  });
            }
            return const Spacer(flex: 1);
          })),
    );
  }
}
