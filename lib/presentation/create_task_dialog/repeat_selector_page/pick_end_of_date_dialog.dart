import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/generic_picker_dialog.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class PickEndOfDateDialog extends StatefulWidget {
  const PickEndOfDateDialog({super.key});

  @override
  State<PickEndOfDateDialog> createState() => _PickEndOfDateDialogState();
}

class _PickEndOfDateDialogState extends State<PickEndOfDateDialog> {
  @override
  Widget build(BuildContext context) {
    return GenericPickerDialog(
      height: 400,
      callback: () {},
      children: [
        Container(
          // height: 500,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumBorderRadius),
            color: Theme.of(context).canvasColor,
          ),
          child: CalendarWidget<TaskState>(
              weekdays: context.read<RepeatlyNotifier>().repeatOfDays,
              focusedDay: context.watch<LastDayOfRepeatNotifier>().lastDate,
              recurringEndDate:
                  context.watch<LastDayOfRepeatNotifier>().lastDate,
              changeDate: (DateTime selectedDay) {
                context
                    .read<LastDayOfRepeatNotifier>()
                    .setLastDate(selectedDay);
              }),
        )
      ],
    );
  }
}
