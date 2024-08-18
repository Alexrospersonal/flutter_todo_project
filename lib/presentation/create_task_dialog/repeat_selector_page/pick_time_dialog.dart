import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/generic_picker_dialog.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inner_12_hour_format_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker.dart';

import '../../generic_widgets/nested_time_picker/inner_24_hour_format_picker.dart';

class PickTimeDialog extends StatefulWidget {
  final void Function(DateTime time) callback;
  const PickTimeDialog({super.key, required this.callback});

  @override
  State<PickTimeDialog> createState() => _PickTimeDialogState();
}

class _PickTimeDialogState extends State<PickTimeDialog> {
  DateTime currentTime = DateTime.now();

  void getTime(TimeOfDay time) {
    currentTime = currentTime.copyWith(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return GenericPickerDialog(
        height: 215,
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
        ],
        callback: () {
          widget.callback(currentTime);
        });
  }
}
