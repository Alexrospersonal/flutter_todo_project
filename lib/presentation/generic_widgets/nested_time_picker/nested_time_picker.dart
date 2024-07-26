import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/inne_abstrac_hour_forma_picker.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';


class NestedTimePicker extends StatelessWidget {
  final InnerAbstractHourFormatPicker format12TimePicker;
  final InnerAbstractHourFormatPicker format24TimePicker;
  final String? title;


  const NestedTimePicker({
    super.key,
    required this.format12TimePicker,
    required this.format24TimePicker,
    this.title
  });

  InnerAbstractHourFormatPicker createNestedTimePicker(bool is24HourFormat) {
    if (!is24HourFormat) {
      return format12TimePicker;
    }
    return format24TimePicker;
  }

  @override
  Widget build(BuildContext context) {
    final bool is24HourFormat =  MediaQuery.of(context).alwaysUse24HourFormat;
    return Column(
      children: [
        if (title != null)
        Text(
          title!.toUpperCase(),
          style: titleStyle,
        ),
        createNestedTimePicker(is24HourFormat)
      ],
    );
  }
}

