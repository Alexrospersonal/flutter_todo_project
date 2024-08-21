import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/dialog_snack_bar_controller.dart';
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
    Provider.of<TaskTimeNotifier>(context, listen: false).setTaskDateTime(
        DateTime.now().copyWith(hour: time.hour, minute: time.minute));
  }

  String formatTime(DateTime time) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    if (is24HourFormat) {
      return "${time.hour}:${time.minute}";
    }
    return DateFormat("hh:mm a", "en_US").format(time);
  }

  @override
  Widget build(BuildContext context) {
    DateTime? taskDateTime = context.watch<TaskTimeNotifier>().taskDateTime;
    var callInformBar = getCallInformBar(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
      child: Selector<TaskTimeNotifier, bool>(
        selector: (context, state) => state.isEnabled,
        builder: (context, isEnabled, child) {
          return Column(
            children: [
              AdditionalSettingsPageHeader(
                text: taskDateTime != null && isEnabled
                    ? formatTime(taskDateTime)
                    : S.of(context).none,
                iconData: Icons.schedule_rounded,
                state: isEnabled,
                callback: (bool state) {
                  var res =
                      context.read<TaskTimeNotifier>().setIsEnabled(state);
                  if (!res) {
                    callInformBar(SnackBarMessageType.noEnabledDate);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: !isEnabled,
                child: Opacity(
                  opacity: isEnabled ? 1 : 0.5,
                  child: NestedTimePicker(
                    // title: S.of(context).selectNotificationTime,
                    format12TimePicker: Inner12HourFormatPicker(
                      initialDate: DateTime.now(),
                      callback: getTimeFromTimePicker,
                      enabled: isEnabled,
                    ),
                    format24TimePicker: Inner24HourFormatPicker(
                      initialDate: DateTime.now(),
                      callback: getTimeFromTimePicker,
                      enabled: isEnabled,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
