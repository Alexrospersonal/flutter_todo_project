import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/utils/format.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/day_in_week_widget/days_in_week_label.dart';
import 'package:provider/provider.dart';

class WeekdaysList extends StatelessWidget {
  const WeekdaysList({super.key});

  @override
  Widget build(BuildContext context) {
    var repeatOfDays = context.watch<RepeatlyNotifier>().repeatOfDays;
    final List<String> weekDays = repeatlyDaysAsUpperChar();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(repeatOfDays.length * 2 - 1, (index) {
            if (index.isEven) {
              int itemIndex = index ~/ 2;
              return DayInWeekLableWidget(
                dayName: weekDays[itemIndex],
                index: itemIndex,
                selectedDay: repeatOfDays[itemIndex],
                callback: (int day) {
                  context.read<RepeatlyNotifier>().setRepeatOfDays(day);
                },
              );
            } else {
              return const Spacer(flex: 1);
            }
          })),
    );
  }
}
