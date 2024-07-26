import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';
import 'package:flutter_todo_project/domain/utils/time_controller.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inne_abstrac_hour_forma_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_period_toggle_Button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker_input.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_templates.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/time_picker_input_separator.dart';
import 'package:intl/intl.dart';

class Inner12HourFormatPicker extends StatefulWidget implements InnerAbstractHourFormatPicker {
  @override
  final DateTime initialDate;

  @override
  final void Function(TimeOfDay time) callback;

  const Inner12HourFormatPicker({
    super.key,
    required this.initialDate,
    required this.callback,
  });

  @override
  State<Inner12HourFormatPicker> createState() => _Inner12HourFormatPickerState();
}

class _Inner12HourFormatPickerState extends State<Inner12HourFormatPicker> {
  late Time12Controller timeFromInput;

  void getAmPmTogglingResult(int position) {
    setState(() {
      timeFromInput = Time12Controller(
        hour: timeFromInput.hour,
        amPm: position,
        minute: timeFromInput.minute
      );
      widget.callback(timeFromInput.getTimeOfDay());
    });
    
  }

  void getTime(int time, TimePickerInputType inputType) {
    setState(() {
      switch (inputType) {
        case TimePickerInputType.hour:
          timeFromInput = Time12Controller(
            hour: time,
            amPm: timeFromInput.amPm,
            minute: timeFromInput.minute
          );
        case TimePickerInputType.minute:
          timeFromInput = Time12Controller(
            hour: timeFromInput.hour,
            amPm: timeFromInput.amPm,
            minute: time
          );
      }
    });
    widget.callback(timeFromInput.getTimeOfDay());
  }

  int get12HourFormat(String formattedTime) {
    return int.parse(formattedTime.split(" ")[0][0]);
  }

  int getAmPm(String formattedTime) {
    var amPm = formattedTime.split(" ")[1].toLowerCase();
    return amPm == "am" ? 0 : 1;
  }

  void setTimeFromTemplates(TimeController time) {
    setState(() {
      timeFromInput = Time12Controller(hour: time.hour, minute: time.minute, amPm: time.amPm);
    });
    widget.callback(timeFromInput.getTimeOfDay());
  }

  @override
  void initState() {
    String formattedTime = DateFormat('h:mm a').format(widget.initialDate);
    int hour = get12HourFormat(formattedTime);
    int amPm = getAmPm(formattedTime);
    timeFromInput = Time12Controller(amPm: amPm, hour: hour, minute: widget.initialDate.minute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.hour,
              initialTime: timeFromInput.hour,
              callback: getTime
            ),
            const TimePickerInputSeparator(),
            NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.minute,
              initialTime: timeFromInput.minute,
              callback: getTime
            ),
            NestedAmPmToggle(
              flex: 0,
              initialValue: timeFromInput.amPm,
              callback: getAmPmTogglingResult,
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        NestedTimeTemplates(
          currentTime: timeFromInput,
          callback: setTimeFromTemplates
        )
    ]);
  }
}

