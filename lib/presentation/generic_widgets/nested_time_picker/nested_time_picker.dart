import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/input_formatters.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/regular_button.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:flutter_todo_project/presentation/styles/time_picker_styles.dart';
import 'package:intl/intl.dart';

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

  late TimeOfDay timeFromInput = TimeOfDay(
    hour: widget.initialDate.hour,
    minute: widget.initialDate.minute
  );

  late int amPm;

  late bool is24HourFormat;

  // TODO: переробити вірне переключання
  //щоб pm міняв годину і навпаки можливо провіряти годину чи вона більше 12 чи ні
  void getAmPmTogglingResult(int position) {
    print("Testing");


    amPm = position;
    if (position == 1) {
      timeFromInput = TimeOfDay(
        hour: timeFromInput.hour,
        minute: timeFromInput.minute
      );
    }
    else {
      var hour = (timeFromInput.hour + 12) % 24;
      timeFromInput = TimeOfDay(hour: hour, minute: timeFromInput.minute);
    }
    print("-- Formated time: $timeFromInput");
  }

  // TODO:  додати перебудову чусу відносно всіз паратметрів
  // Типу я вівів 12 і вібувається перебувдова і проазунок часу
  // Додати початкове значенння для AM/PM відносно години і також його
  // міняти при перебудові
  void getTime(int time, TimePickerInputType inputType) {
    switch (inputType) {
      case TimePickerInputType.hour:
        timeFromInput = convertHourFrom12To24Format(time);
      case TimePickerInputType.minute:
        timeFromInput = TimeOfDay(hour: timeFromInput.hour, minute: time);
    }
    print("-- Formated time: $timeFromInput");
  }

  TimeOfDay convertHourFrom12To24Format(int hour) {
    if (!is24HourFormat) {
      int convertedHour = amPm == 0 ? hour : hour + 12;
      return TimeOfDay(hour: convertedHour, minute: timeFromInput.minute);
    }
    return TimeOfDay(hour: hour, minute: timeFromInput.minute);
  }

  int get12HourFormat(String formattedTime) {
    return int.parse(formattedTime.split(" ")[0][0]);
  }

  int getAmPm(String formattedTime) {
    var amPm = formattedTime.split(" ")[1].toLowerCase();
    return amPm == "am" ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    is24HourFormat =  MediaQuery.of(context).alwaysUse24HourFormat;

    int hour = widget.initialDate.hour;
    int minute = widget.initialDate.minute;
    

    if (!is24HourFormat) {
      String formattedTime = DateFormat('h:mm a').format(widget.initialDate);
      hour = get12HourFormat(formattedTime);
      amPm = getAmPm(formattedTime);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
        Text(
          widget.title!.toUpperCase(),
          style: titleStyle,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.hour,
              initialTime: hour,
              callback: getTime
            ),
            const TimePickerInputSeparator(),
            NestedTimePickerInput(
              flex: 1,
              inputType: TimePickerInputType.minute,
              initialTime: minute,
              callback: getTime
            ),
            if (!is24HourFormat)
              NestedAmPmToggle(
                flex: 0,
                initialValue: amPm,
                callback: getAmPmTogglingResult,
              )
          ],
        ),
    ]);
  }
}

class NestedAmPmToggle extends StatefulWidget {
  final void Function(int) callback;
  final int flex;
  final int initialValue;

  const NestedAmPmToggle({
    super.key,
    required this.flex,
    required this.initialValue,
    required this.callback
  });

  @override
  State<NestedAmPmToggle> createState() => _NestedAmPmToggleState();
}

class _NestedAmPmToggleState extends State<NestedAmPmToggle> {
  List<bool> isSelected = [false, false];

  @override
  void initState() {
    super.initState();
    isSelected[widget.initialValue] = true;
  }

  @override
  Widget build(BuildContext context) {

    return Flexible(
      flex: widget.flex,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          color: inputBackgroundColor,
        ),
        child: ToggleButtons(
          direction: Axis.vertical,
          constraints: const BoxConstraints(
            maxHeight: 37
          ),
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          isSelected: isSelected,
          onPressed: (index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
            widget.callback(index);
          },
          children: const [
          SizedBox(
            width: 43,
            child: Center(
              child: Text(
                "AM",
                style: regularButtonTextStyle
                )
            ),
          ),
          SizedBox(
            width: 43,
            child: Center(
              child: Text(
                "PM",
                style: regularButtonTextStyle,
              )
            ),
          ),
        ],
        ),
      )
    );
  }
}

class NestedTimePickerInput extends StatefulWidget {
  final int flex;
  final TimePickerInputType inputType;
  final int initialTime;
  final void Function(int, TimePickerInputType) callback;

  const NestedTimePickerInput({
    super.key,
    required this.flex,
    required this.inputType,
    required this.initialTime,
    required this.callback
  });

  @override
  State<NestedTimePickerInput> createState() => _NestedTimePickerInputState();
}

class _NestedTimePickerInputState extends State<NestedTimePickerInput> {
  TextEditingController controller = TextEditingController();
  
  
  int getMaxValue(BuildContext context) {
    final bool is24HourFormat =  MediaQuery.of(context).alwaysUse24HourFormat;

    switch (widget.inputType) {
      case TimePickerInputType.hour:
        return is24HourFormat ? 24 : 13;
      case TimePickerInputType.minute:
        return 60;
    }
  }

  @override
  void initState() {
    super.initState();
    controller.text =  widget.initialTime.toString().padLeft(2, "0");
  }

  @override
  Widget build(BuildContext context) {
    final int maxValue = getMaxValue(context);
    
    return Flexible(
      flex: 1,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: getNumberInputFormatters(maxValue),
        maxLength: 2,
        textAlign: TextAlign.center,
        cursorHeight: 50,
        textAlignVertical: TextAlignVertical.center,
        decoration: timePickerInputStyle,
        onSubmitted: (value) {
          setState(() {
            widget.callback(
              int.parse(controller.text),
              widget.inputType
            );
          });
        },
        onTapOutside: (event) {
          setState(() {
            widget.callback(
              int.parse(controller.text),
              widget.inputType
            );
          });
          FocusScope.of(context).unfocus();
        },
        style: timePickerTextStyle
      ),
    );
  }
}

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