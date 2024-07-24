import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/time_picker_styles.dart';

class TimePickerInputSeparator extends StatelessWidget {
  const TimePickerInputSeparator({super.key});
  
  @override
  Widget build(Object context) {
    return Flexible(
        flex: 0,
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: const Text(
            ":",
            style: timePickerInputSeparatorStyle
          ),
        ),
    );
  }
}