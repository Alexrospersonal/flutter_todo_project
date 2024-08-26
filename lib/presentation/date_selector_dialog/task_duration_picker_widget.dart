import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_alert_dialog.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_time_picker_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskDurationPickerWidget extends StatefulWidget {
  const TaskDurationPickerWidget({
    super.key,
  });

  @override
  State<TaskDurationPickerWidget> createState() =>
      _TaskDurationPickerWidgetState();
}

class _TaskDurationPickerWidgetState extends State<TaskDurationPickerWidget> {
  bool isActive = false;
  bool notificatioOfEnd = false;
  int hourFormat = 24;

  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime? endDate;

  String getStartDurationDate(bool hasTime, DateTime? time) {
    if (hasTime) {
      return DateFormat('dd/MM/yyyy HH:mm').format(time!);
    } else {
      return "Немає";
    }
  }

  String getEndDurationDate(bool hasTime, DateTime? time) {
    if (hasTime) {
      DateTime startDate =
          Provider.of<TaskStateDeprecated>(context, listen: false)
              .taskDateTime!;
      DateTime endDate =
          startDate.add(Duration(hours: time!.hour, minutes: time.minute));
      return DateFormat('dd/MM/yyyy HH:mm').format(endDate);
    } else {
      return "Немає";
    }
  }

  void onChangedTime(int? hour, int? minute) {
    if (hour != null) {
      Provider.of<TaskStateDeprecated>(context, listen: false)
          .setDurationHour(hour);
    }
    if (minute != null) {
      Provider.of<TaskStateDeprecated>(context, listen: false)
          .setDurationMinute(minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskStateDeprecated state = context.read<TaskStateDeprecated>();

    var switchIsActiveStatus = state.setHasDuration;
    var swithEndOfNotication = state.setNotifyAboutTheEndOfTheTask;
    // String startDurationTime

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Header Row
        const Row(
          children: [
            Text(
              "Твивалість завдання",
              style: TextStyle(
                  fontSize: 18, height: 1, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        // Row with switchers
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<TaskStateDeprecated, bool>(
              selector: (context, state) => state.hasDuration,
              builder: (context, hasDuration, child) => SwitchWithLabel(
                  state: hasDuration,
                  label: hasDuration
                      ? "Вимкнути\nтривалість"
                      : "Увімкнути\nтривалість",
                  callback: (bool state) {
                    bool res = switchIsActiveStatus(state);

                    if (!res) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return const CustomAlerDialog(
                            errorMessage: 'Виберіть спочатку година',
                          );
                        },
                      );
                    }
                  }),
            ),
            Selector<TaskStateDeprecated, bool>(
              selector: (context, state) => state.notifyAboutTheEndOfTheTask,
              builder: (context, notifyAboutTheEndOfTheTask, child) =>
                  SwitchWithLabel(
                      state: notifyAboutTheEndOfTheTask,
                      label: "Сповіщати\nпро кінець",
                      callback: swithEndOfNotication),
            ),
          ],
        ),
        Selector<TaskStateDeprecated, DateTime?>(
          selector: (context, state) => state.taskDuration,
          builder: (context, taskDuration, child) => CustomTimePicker(
            isEnabled: state.hasTime,
            time: taskDuration,
            callback: onChangedTime,
          ),
        ),
        // Row with times
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // Hours
        //     Flexible(
        //       flex: 1,
        //       child: NumberInput(
        //         name: "Години",
        //         maxValue: hourFormat,
        //         controller: hoursController,
        //         enabled: isActive,
        //         onChanged: () {},
        //       )
        //     ),
        //     const Flexible(
        //       flex: 0,
        //       child: DoubleDotTimeDivider()
        //       ),
        //     Flexible(
        //       flex: 1,
        //       child: NumberInput(
        //         name: "Хвилини",
        //         maxValue: 60,
        //         controller: minutesController,
        //         enabled: isActive,
        //         onChanged: () {},
        //       )
        //     ),
        //   ],
        // ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<TaskStateDeprecated, DateTime?>(
              selector: (context, state) => state.taskDateTime,
              builder: (context, taskDateTime, child) => Text(
                "Початок:\n${getStartDurationDate(state.hasTime, taskDateTime)}",
                style: const TextStyle(height: 1, fontSize: 16),
              ),
            ),
            Selector<TaskStateDeprecated, DateTime?>(
              selector: (context, state) => state.taskDuration,
              builder: (context, taskDuration, child) => Text(
                "Кінець:\n${getEndDurationDate(state.hasDuration, taskDuration)}",
                textAlign: TextAlign.end,
                style: const TextStyle(
                  height: 1,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
