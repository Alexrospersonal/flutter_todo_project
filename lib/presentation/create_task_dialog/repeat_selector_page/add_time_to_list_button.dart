import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_selector_page.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class AddTimeToListButton extends StatefulWidget {
  final void Function(DateTime? time, int idx) callback;
  final DateTime? time;
  final int index;

  const AddTimeToListButton(
      {super.key,
      required this.index,
      required this.time,
      required this.callback});

  @override
  State<AddTimeToListButton> createState() => _AddTimeToListButtonState();
}

class _AddTimeToListButtonState extends State<AddTimeToListButton> {
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
