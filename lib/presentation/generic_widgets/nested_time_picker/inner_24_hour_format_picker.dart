import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';
import 'package:flutter_todo_project/domain/utils/time_controller.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inne_abstrac_hour_forma_picker.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker_input.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_templates.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/time_picker_input_separator.dart';

class Inner24HourFormatPicker extends StatefulWidget
    implements InnerAbstractHourFormatPicker {
  @override
  final DateTime initialDate;

  @override
  final bool enabled;

  @override
  final void Function(TimeOfDay time) callback;

  const Inner24HourFormatPicker(
      {super.key,
      required this.initialDate,
      required this.callback,
      required this.enabled});

  @override
  State<Inner24HourFormatPicker> createState() =>
      _Inner24HourFormatPickerState();
}

class _Inner24HourFormatPickerState extends State<Inner24HourFormatPicker> {
  late Time24Controller timeFromInput;

  void getTime(int time, TimePickerInputType inputType) {
    setState(() {
      switch (inputType) {
        case TimePickerInputType.hour:
          timeFromInput =
              Time24Controller(hour: time, minute: timeFromInput.minute);
        case TimePickerInputType.minute:
          timeFromInput =
              Time24Controller(hour: timeFromInput.hour, minute: time);
      }
    });
    widget.callback(timeFromInput.getTimeOfDay());
  }

  void setTimeFromTemplates(TimeController time) {
    setState(() {
      timeFromInput = Time24Controller(hour: time.hour, minute: time.minute);
    });
    widget.callback(timeFromInput.getTimeOfDay());
  }

  @override
  void initState() {
    timeFromInput = Time24Controller(
        hour: widget.initialDate.hour, minute: widget.initialDate.minute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.hour,
              initialTime: timeFromInput.hour,
              callback: getTime,
              enabled: widget.enabled),
          const TimePickerInputSeparator(),
          NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.minute,
              initialTime: timeFromInput.minute,
              callback: getTime,
              enabled: widget.enabled),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      // TODO: написати щоб воно нормально працбвало з 24 годинами
      NestedTimeTemplates(
          currentTime: Time24Controller(
              hour: timeFromInput.hour, minute: timeFromInput.minute),
          callback: setTimeFromTemplates)
    ]);
  }
}
