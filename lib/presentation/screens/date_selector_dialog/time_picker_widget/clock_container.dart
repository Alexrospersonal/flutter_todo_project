import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/double_dot_time_divider.dart';

class TimePickerInputsContainerWidget extends StatelessWidget {
  final Widget hourInput;
  final Widget minuteInput;
  final Widget amPmToggleInput;
  final bool twelveHourFormat;

  const TimePickerInputsContainerWidget({
    super.key,
    required this.hourInput,
    required this.minuteInput,
    required this.amPmToggleInput,
    required this.twelveHourFormat,
  });
  
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Hours
        Flexible(
          flex: 3,
          child: hourInput
        ),
        const Flexible(
          flex: 0,
          child: DoubleDotTimeDivider()
          ),
        Flexible(
          flex: 3,
          child: minuteInput
        ),
        if (twelveHourFormat)
          Flexible(
          flex: 2,
          child: amPmToggleInput
         )
      ],
    );
  } 
}