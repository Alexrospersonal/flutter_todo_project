import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/utils/time_format_data.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/am_pm_toggle_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';

class CustomTimePicker extends ConsumerStatefulWidget {
  final bool isEnabled;
  final void Function(int? hour, int? minute) callback;
  final DateTime? time;

  const CustomTimePicker({
    super.key,
    required this.isEnabled,
    required this.time,
    required this.callback
  });

  @override
  ConsumerState<CustomTimePicker> createState() => _ClockState();
}

class _ClockState extends ConsumerState<CustomTimePicker> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  List<bool> amPmStatus = [false, false];

  void onChangedHour() {
    widget.callback(int.parse(hourController.text), null);
  }

  void onChangedMinute() {
    widget.callback(null, int.parse(hourController.text));
  }

  void switchAmPmInClock(String amPm) {
    if (amPm.isNotEmpty) {
      int index = amPm.toLowerCase() == "am" ? 0 : 1;
      amPmStatus = [false, false];
      amPmStatus[index] = true;
    }
  }

  void setTimeToTimeControllers(String hour, String minute) {
    hourController.text = hour;
    minuteController.text = minute;
  }

  @override
  void dispose() {
    super.dispose();

    hourController.dispose();
    minuteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    var timeFormatData = TimeFormatData.getTimeFormatData(widget.time, is24HourFormat);
    setTimeToTimeControllers(timeFormatData.hour,timeFormatData.minute);
    switchAmPmInClock(timeFormatData.amPm);

    return TimePickerInputsContainerWidget(
      hourInput:NumberInput(
        name: "Години",
        maxValue: is24HourFormat ? 24 : 13,
        controller: hourController,
        enabled: widget.isEnabled,
        onChanged: onChangedHour,
      ),
      minuteInput: NumberInput(
        name: "Хвилини",
        maxValue: 60,
        controller: minuteController,
        enabled: widget.isEnabled,
        onChanged: onChangedMinute,
      ),
      amPmToggleInput: AmPmToggleContainer(
        isSelected: amPmStatus,
      ),
      twelveHourFormat: !is24HourFormat,
    );
  }
}