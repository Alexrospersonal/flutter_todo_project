import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/regular_button.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
import 'package:flutter_todo_project/presentation/styles/time_picker_styles.dart';

// TODO: додати AM/PM та написати логіку
class NestedTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final void Function(TimeOfDay?) getTime;
  final String? title;

  const NestedTimePicker({
    super.key,
    required this.initialDate,
    required this.getTime,
    this.title
  });

  @override
  State<NestedTimePicker> createState() => _NestedTimePickerState();
}

class _NestedTimePickerState extends State<NestedTimePicker> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 195,
      // constraints: BoxConstraints(
      //   maxHeight: 220,
      //   minHeight: 190
      // ),
      padding: const EdgeInsets.all(cardPadding),
      decoration: outerCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
          Text(
            widget.title!.toUpperCase(),
            style: titleStyle,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NestedTimePickerInput(
                flex: 1,
                controller: hourController,  
              ),
              const TimePickerInputSeparator(),
              NestedTimePickerInput(
                flex: 1,
                controller: minuteController,  
              )
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegularButton(
                text: "Cancel",
                style: cancelButtonStyle,
                onPressed: () {},
              ),
              RegularButton(
                text: "Done",
                style: comfirmButtonStyle,
                onPressed: () {},
              ),
            ],
          )
      ]),
    );
  }
}

class NestedTimePickerInput extends StatelessWidget {
  final int flex;
  final TextEditingController controller;

  const NestedTimePickerInput({
    super.key,
    required this.flex,
    required this.controller
  });
  
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 2,
        textAlign: TextAlign.center,
        cursorHeight: 55,
        textAlignVertical: TextAlignVertical.center,
        decoration: timePickerInputStyle,
        style: timePickerTextStyle
      ),
    );
  }
}

class TimePickerInputSeparator extends StatelessWidget {
  const TimePickerInputSeparator({super.key});
  
  @override
  Widget build(Object context) {
    return const Flexible(
        flex: 0,
        child: Text(
        ":",
        style: timePickerInputSeparatorStyle
      ),
    );
  }
}