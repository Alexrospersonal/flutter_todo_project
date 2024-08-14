import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/input_formatters.dart';
import 'package:flutter_todo_project/presentation/styles/time_picker_styles.dart';

class NestedTimePickerInput extends StatefulWidget {
  final int flex;
  final TimePickerInputType inputType;
  final int initialTime;
  final void Function(int, TimePickerInputType) callback;
  final bool enabled;

  const NestedTimePickerInput(
      {super.key,
      required this.flex,
      required this.inputType,
      required this.initialTime,
      required this.callback,
      required this.enabled});

  @override
  State<NestedTimePickerInput> createState() => _NestedTimePickerInputState();
}

class _NestedTimePickerInputState extends State<NestedTimePickerInput> {
  TextEditingController controller = TextEditingController();
  late bool is24HourFormat;

  int getMaxValue() {
    switch (widget.inputType) {
      case TimePickerInputType.hour:
        return is24HourFormat ? 24 : 13;
      case TimePickerInputType.minute:
        return 60;
    }
  }

  bool validateIfHourIsNotNull() {
    return !is24HourFormat &&
        widget.inputType == TimePickerInputType.hour &&
        int.parse(controller.text) == 0;
  }

  void setPreviousNumbersIfControllerIsEmpty(String previousNumbers) {
    if (controller.text.isEmpty || validateIfHourIsNotNull()) {
      controller.text = previousNumbers;
    }
  }

  void sendNumbersToParrent() {
    setState(() {
      widget.callback(int.parse(controller.text), widget.inputType);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final int maxValue = getMaxValue();
    controller.text = widget.initialTime.toString().padLeft(2, "0");
    String previousNumbers = controller.text;

    return Flexible(
      flex: 1,
      child: TextField(
          controller: controller,
          enabled: widget.enabled,
          keyboardType: TextInputType.number,
          inputFormatters: getNumberInputFormatters(maxValue),
          maxLength: 2,
          textAlign: TextAlign.center,
          cursorHeight: 58,
          textAlignVertical: TextAlignVertical.center,
          decoration: timePickerInputStyle,
          onSubmitted: (value) {
            setPreviousNumbersIfControllerIsEmpty(previousNumbers);
            sendNumbersToParrent();
          },
          onTapOutside: (event) {
            setPreviousNumbersIfControllerIsEmpty(previousNumbers);
            sendNumbersToParrent();
            FocusScope.of(context).unfocus();
          },
          style: timePickerTextStyle),
    );
  }
}
