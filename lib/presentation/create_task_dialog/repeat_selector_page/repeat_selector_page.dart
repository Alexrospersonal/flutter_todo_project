import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/day_in_week_widget/days_in_week_label.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_12_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_24_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class RepeatSelectorPage extends StatefulWidget {
  const RepeatSelectorPage({super.key});

  @override
  State<RepeatSelectorPage> createState() => _RepeatSelectorPageState();
}

class _RepeatSelectorPageState extends State<RepeatSelectorPage> {
  final List<bool> selectedWeekdays = List.generate(7, (int dayIdx) => false);
  final List<DateTime?> repeatTimes = [null, DateTime.now(), null, null];
  bool isRepeatOfDays = false;
  bool isLastDayOfRepeat = false;
  bool isRepeatInTime = false;

  List<String> repeatlyDaysAsStrings() {
    final dateFormat = DateFormat('E');

    final DateTime now = DateTime.now();

    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));

    return List.generate(7, (index) {
      final DateTime day = startOfWeek.add(Duration(days: index));
      return dateFormat.format(day)[0].toUpperCase();
    });
  }

  void setRepeatTime(DateTime? time, int idx) {
    setState(() {
      repeatTimes[idx] = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = repeatlyDaysAsStrings();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
      child: Column(
        children: [
          AdditionalSettingsPageHeader(
            text: "Repeat of days",
            iconData: Icons.timer,
            state: isRepeatOfDays,
            callback: (bool state) {
              setState(() {
                isRepeatOfDays = !isRepeatOfDays;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(weekDays.length, (index) {
                return DayInWeekLableWidget(
                  dayName: weekDays[index],
                  index: index,
                  selectedDay: selectedWeekdays[index],
                  callback: (int day) {
                    setState(() {
                      selectedWeekdays[index] = !selectedWeekdays[index];
                    });
                  },
                );
              })),
          const SizedBox(
            height: 10,
          ),
          AdditionalSettingsPageHeader(
            text: "Add Last day of repeat",
            iconData: Icons.add,
            state: isLastDayOfRepeat,
            callback: (bool state) {
              setState(() {
                isLastDayOfRepeat = !isLastDayOfRepeat;
              });
            },
          ),
          AdditionalSettingsPageHeader(
            text: "Repeat in time",
            iconData: Icons.repeat,
            state: isRepeatInTime,
            callback: (bool state) {
              setState(() {
                isRepeatInTime = !isRepeatInTime;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  4,
                  (int idx) => AddRepeatInTimeButton(
                        index: idx,
                        time: repeatTimes[idx],
                        callback: setRepeatTime,
                      ))),
          const SizedBox(
            height: 15,
          ),
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
