import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_12_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_24_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeSelectorPage extends StatefulWidget {
  const TimeSelectorPage({super.key});

  @override
  State<TimeSelectorPage> createState() => _TimeSelectorPageState();
}

class _TimeSelectorPageState extends State<TimeSelectorPage> {
  void getTimeFromTimePicker(TimeOfDay time) {
    Provider.of<TaskState>(context, listen: false)
        .setTime(time.hour, time.minute);
  }

  String formatTime(DateTime time) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    if (is24HourFormat) {
      return "${time.hour}:${time.minute}";
    }
    return DateFormat("hh:mm a", "en_US").format(time);
  }

  // TODO: add snack bar when date isn't picked.
  // Можливо створити один снек бар і його викликати з різних мість для різної інформації
  @override
  Widget build(BuildContext context) {
    return Selector<TaskState, DateTime?>(
        selector: (context, state) => state.taskDateTime,
        builder: (context, taskDateTime, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
            child: Selector<TaskState, bool>(
              selector: (context, state) => state.hasTime,
              builder: (context, hasTime, child) {
                return Column(
                  children: [
                    AdditionalSettingsPageHeader(
                      text: taskDateTime != null && hasTime
                          ? formatTime(taskDateTime)
                          : S.of(context).none,
                      iconData: Icons.schedule_rounded,
                      state: hasTime,
                      callback: (bool state) {
                        context.read<TaskState>().setHasTime(state);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IgnorePointer(
                      ignoring: !hasTime,
                      child: Opacity(
                        opacity: hasTime ? 1 : 0.5,
                        child: NestedTimePicker(
                          // title: S.of(context).selectNotificationTime,
                          format12TimePicker: Inner12HourFormatPicker(
                            initialDate: DateTime.now(),
                            callback: getTimeFromTimePicker,
                            enabled: hasTime,
                          ),
                          format24TimePicker: Inner24HourFormatPicker(
                            initialDate: DateTime.now(),
                            callback: getTimeFromTimePicker,
                            enabled: hasTime,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
