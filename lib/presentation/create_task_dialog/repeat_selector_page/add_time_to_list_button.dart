import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/pick_time_dialog.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import 'package:provider/provider.dart';

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

  void callShowGeneralDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Add Task",
      barrierColor: Colors.white.withOpacity(0.5),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
            child: PickTimeDialog(
              callback: (time) {
                widget.callback(time, widget.index);
              },
            ));
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = widget.time != null
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    Color splashColor = widget.time != null
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).splashColor;

    Widget child = widget.time != null
        ? Text(
            formatTime(widget.time!),
            style:
                TextStyle(color: Theme.of(context).canvasColor, fontSize: 14),
          )
        : const Icon(Icons.add);

    return SizedBox(
      height: 32,
      child: ElevatedButton(
          onPressed: () {
            bool isEnabled = context.read<RepeatInTimeNotifier>().isEnabled;

            if (isEnabled) {
              callShowGeneralDialog();
            }
          },
          onLongPress: () {
            Vibration.vibrate(duration: 50, amplitude: 1);
            widget.callback(null, widget.index);
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(bgColor),
              overlayColor: WidgetStatePropertyAll(splashColor),
              splashFactory: InkSplash.splashFactory,
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 8))),
          child: child),
    );
  }
}
