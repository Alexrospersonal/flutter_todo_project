import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_alert_dialog.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_time_picker_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/time_picker_widget/time_template_container.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/time_picker_widget/time_template_item.dart';
import 'package:provider/provider.dart';

class TaskTimePickerWidget extends StatefulWidget {
  const TaskTimePickerWidget({
    super.key,
  });

  @override
  State<TaskTimePickerWidget> createState() => _TaskTimePickerWidgetState();
}

class _TaskTimePickerWidgetState extends State<TaskTimePickerWidget> {
  bool fromAllDay = false;
  bool twelveHourFormat = false;
  int hourFormat = 24;

  void changeFromAllDay(value) {
    bool result = Provider.of<TaskStateDeprecated>(context, listen: false)
        .setHasTime(value);
    if (!result) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const CustomAlerDialog(
            errorMessage: 'Виберіть спочатку дату',
          );
        },
      );
    }
  }

  void addTimeToTime(int hour, int minute) {
    TaskStateDeprecated taskState =
        Provider.of<TaskStateDeprecated>(context, listen: false);

    if (taskState.taskDateTime != null) {
      taskState.setTime(taskState.taskDateTime!.hour + hour,
          taskState.taskDateTime!.minute + minute);
    }
  }

  void onChangedTime(int? hour, int? minute) {
    if (hour != null) {
      Provider.of<TaskStateDeprecated>(context, listen: false).setHour(hour);
    }
    if (minute != null) {
      Provider.of<TaskStateDeprecated>(context, listen: false)
          .setMinute(minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasTime = context.watch<TaskStateDeprecated>().hasTime;

    return Selector<TaskStateDeprecated, DateTime?>(
      selector: (context, state) => state.taskDateTime,
      builder: (context, taskDateTime, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchWithLabel(
                state: hasTime,
                label: "Додати час",
                callback: changeFromAllDay,
              ),
              const SizedBox(height: 5),
              CustomTimePicker(
                isEnabled: hasTime,
                time: taskDateTime,
                callback: onChangedTime,
              ),
              const SizedBox(height: 10),
              TimeTemplatesContainer(
                children: [
                  TimeTemplateItem(
                      callback: addTimeToTime, hour: 1, minutes: 0),
                  TimeTemplateItem(
                      callback: addTimeToTime, hour: 0, minutes: 30),
                  TimeTemplateItem(
                      callback: addTimeToTime, hour: 12, minutes: 0),
                  TimeTemplateItem(
                      callback: addTimeToTime, hour: 3, minutes: 45),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
