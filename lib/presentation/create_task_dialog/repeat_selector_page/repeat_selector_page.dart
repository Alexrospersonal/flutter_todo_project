import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/repeatly_notifier.dart';
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

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
          const SizedBox(height: 10),
          const WeekdaysList(),
          // TODO: виправити наступні елементи, забрати з них selector.
          const SizedBox(height: 10),
          const LastDayOfRepeat(),
          const RepeatInTimesSelector(),
          const SizedBox(height: 10),
          const RepeatInTimesList(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class AddRepeatInTimeButton extends StatefulWidget {
  final void Function(DateTime? time, int idx) callback;
  final DateTime? time;
  final int index;

  const AddRepeatInTimeButton(
      {super.key,
      required this.index,
      required this.time,
      required this.callback});

  @override
  State<AddRepeatInTimeButton> createState() => _AddRepeatInTimeButtonState();
}

class _AddRepeatInTimeButtonState extends State<AddRepeatInTimeButton> {
  String formatTime(DateTime time) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    if (is24HourFormat) {
      return "${time.hour}:${time.minute}";
    }
    return DateFormat("hh:mm a", "en_US").format(time);
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = widget.time != null
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    Widget child = widget.time != null
        ? Text(
            formatTime(widget.time!),
            style: TextStyle(color: Theme.of(context).canvasColor),
          )
        : const Icon(Icons.add);

    return GestureDetector(
      onLongPress: () {
        Vibration.vibrate(duration: 50, amplitude: 1);
        widget.callback(null, widget.index);
      },
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel: "Add Task",
          barrierColor: Colors.white.withOpacity(0.5),
          pageBuilder: (context, anim1, anim2) {
            return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
                child: PickerDialog(
                  callback: (time) {
                    widget.callback(time, widget.index);
                  },
                ));
          },
          transitionDuration: const Duration(milliseconds: 100),
        );
        // TODO: calling diaglog with time picker
      },
      child: Container(
        width: 70,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            color: bgColor),
        child: Center(child: child),
      ),
    );
  }
}

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
