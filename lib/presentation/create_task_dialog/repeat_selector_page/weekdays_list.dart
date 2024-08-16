import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/repeatly_notifier.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/day_in_week_widget/days_in_week_label.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeekdaysList extends StatelessWidget {
  const WeekdaysList({super.key});

  List<String> repeatlyDaysAsStrings() {
    final dateFormat = DateFormat('E');

    final DateTime now = DateTime.now();

    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));

    return List.generate(7, (index) {
      final DateTime day = startOfWeek.add(Duration(days: index));
      return dateFormat.format(day)[0].toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = repeatlyDaysAsStrings();
    var repeatOfDays = context.watch<RepeatlyNotifier>().repeatOfDays;

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(repeatOfDays.length, (index) {
          return DayInWeekLableWidget(
            dayName: weekDays[index],
            index: index,
            selectedDay: repeatOfDays[index],
            callback: (int day) {
              context.read<RepeatlyNotifier>().setRepeatOfDays(day);
            },
          );
        }));
  }
}
