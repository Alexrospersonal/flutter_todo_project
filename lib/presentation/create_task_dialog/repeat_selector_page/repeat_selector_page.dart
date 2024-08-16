import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/last_day_of_repeat.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_in_times_list.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_in_times_selector.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/weekdays_list.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_12_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_24_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class RepeatSelectorPage extends StatefulWidget {
  const RepeatSelectorPage({super.key});

  @override
  State<RepeatSelectorPage> createState() => _RepeatSelectorPageState();
}

class _RepeatSelectorPageState extends State<RepeatSelectorPage> {
  @override
  Widget build(BuildContext context) {
    bool isRepeatOfDays = context.watch<RepeatlyNotifier>().isEnabled;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
      child: Column(
        children: [
          AdditionalSettingsPageHeader(
            text: S.of(context).repeatOfdays,
            iconData: Icons.timer,
            state: isRepeatOfDays,
            callback: (bool state) {
              context.read<RepeatlyNotifier>().setIsRepeatOfDays(state);
            },
          ),
          const WeekdaysList(),
          const LastDayOfRepeat(),
          const RepeatInTimesSelector(),
          const RepeatInTimesList(),
        ],
      ),
    );
  }
}

// TODO: рефактор коду. Можливо dialog та контент окремо
class PickerDialog extends StatefulWidget {
  final void Function(DateTime time) callback;
  const PickerDialog({super.key, required this.callback});

  @override
  State<PickerDialog> createState() => _PickerDialogState();
}

class _PickerDialogState extends State<PickerDialog> {
  DateTime currentTime = DateTime.now();

  void getTime(TimeOfDay time) {
    currentTime = currentTime.copyWith(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.76),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bigBorderRadius)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Container(
          height: 215,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: NestedTimePicker(
                  // title: S.of(context).selectNotificationTime,
                  format12TimePicker: Inner12HourFormatPicker(
                    initialDate: currentTime,
                    callback: getTime,
                    enabled: true,
                  ),
                  format24TimePicker: Inner24HourFormatPicker(
                    initialDate: currentTime,
                    callback: getTime,
                    enabled: true,
                  ),
                ),
              ),
              DoneButton(
                action: () {
                  widget.callback(currentTime);
                  return true;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimePickerForTimeRepeat extends StatefulWidget {
  const TimePickerForTimeRepeat({super.key});

  @override
  State<TimePickerForTimeRepeat> createState() =>
      _TimePickerForTimeRepeatState();
}

class _TimePickerForTimeRepeatState extends State<TimePickerForTimeRepeat> {
  var currentTime = DateTime.now();
  void getTime(TimeOfDay time) {
    currentTime = currentTime.copyWith(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: NestedTimePicker(
        format12TimePicker: Inner12HourFormatPicker(
          initialDate: currentTime,
          callback: getTime,
          enabled: true,
        ),
        format24TimePicker: Inner24HourFormatPicker(
          initialDate: currentTime,
          callback: getTime,
          enabled: true,
        ),
      ),
    );
  }
}
