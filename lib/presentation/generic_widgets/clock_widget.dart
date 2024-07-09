import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/am_pm_toggle_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';
import 'package:intl/intl.dart';

class Clock extends ConsumerStatefulWidget {
  final bool isEnabled;
  final void Function(int? hour, int? minute) callback;
  final DateTime? time;

  const Clock({
    super.key,
    required this.isEnabled,
    required this.time,
    required this.callback
  });

  @override
  ConsumerState<Clock> createState() => _ClockState();
}

class _ClockState extends ConsumerState<Clock> {
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
      amPmStatus = [false, false];
      int index = amPm.toLowerCase() == "am" ? 0 : 1;
      amPmStatus[index] = true;
    }
  }

  List<String> format24timeToClock() {
    String hour = "";
    String minute = "";

    if (widget.time != null) {
      hour = widget.time!.hour.toString().padLeft(2, '0');
      minute =  widget.time!.minute.toString().padLeft(2, '0');
    }

    return [hour, minute];
  }

  Map<String, String> format12timeToClock() {
    Map<String, String> timeObject = {
      "hour": "",
      "minute": "",
      "amPm": ""
    };

    if (widget.time != null) {
      String formattedTime = DateFormat('hh:mm a').format(widget.time!);
      List<String> splitedFormatedTime = formattedTime.split(' ');
      List<String> time = splitedFormatedTime[0].split(":");

      timeObject["hour"] = time[0];
      timeObject["minute"] = time[1];
      timeObject["amPm"] = splitedFormatedTime[1];
    }

    // return hour minute and am/pm
    return timeObject;
  }

  void setTimeToTimeControllers(String hour, String minute) {
    hourController.text = hour;
    minuteController.text = minute;
  }

  @override
  Widget build(BuildContext context) {
    
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    if (is24HourFormat) {
      var time = format24timeToClock();
      setTimeToTimeControllers(time[0], time[1]);
    } else {
      Map<String, String> time = format12timeToClock();
      setTimeToTimeControllers(time["hour"]!, time["minute"]!);
      switchAmPmInClock(time["amPm"]!);
    }

    return ClockContainerWidget(
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
        callback: (String s) {},
        isSelected: amPmStatus,
      ),
      twelveHourFormat: !is24HourFormat,
    );
  }
}