import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:provider/provider.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Selector<TaskState, bool>(
      selector: (context, state) => state.hasDate,
      builder: (context, hasDate, child) {
        return Column(
          children: [
            SwitchWithLabel(
              state: hasDate,
              label: "Дата завдання",
              callback: (state) {
                context.read<TaskState>().setHasDate(state);
              }
            ),
            Opacity(
              opacity: hasDate ? 1 : 0.5,
              child: IgnorePointer(
                ignoring: hasDate ? false : true,
                child: CalendarWidget<TaskState>(
                  weekdays: context.watch<TaskState>().recurringDays,
                  recurringEndDate: context.watch<TaskState>().recurringEndDate,
                  changeDate: (DateTime selectedDay) {
                    context.read<TaskState>().setDate(selectedDay);
                  }
                )
              ),
            )
          ],
        );
      },
    );
  }
}