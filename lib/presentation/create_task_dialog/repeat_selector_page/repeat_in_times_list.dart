import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/repeatly_notifier.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_selector_page.dart';
import 'package:provider/provider.dart';

class RepeatInTimesList extends StatelessWidget {
  const RepeatInTimesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RepeatInTimeNotifier, List<DateTime?>>(
      selector: (context, state) => state.times,
      builder: (context, times, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              4,
              (int idx) => AddRepeatInTimeButton(
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
