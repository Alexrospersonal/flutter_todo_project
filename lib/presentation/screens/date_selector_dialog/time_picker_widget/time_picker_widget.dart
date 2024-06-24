import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/date_selector/date_selector_widget.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/am_pm_toggle_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/double_dot_time_divider.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/time_template_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/time_template_item.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    super.key,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  bool fromAllDay = false;
  bool twelveHourFormat = false;
  int hourFormat = 24;
  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hoursController.text = DateTime.now().hour.toString().padLeft(2, '0');
    minutesController.text = DateTime.now().minute.toString().padLeft(2, '0');
  }

  void changeFromAllDay(value) => setState(() {
    fromAllDay = !fromAllDay;
    if (fromAllDay) {
      hoursController.clear();
      minutesController.clear();
      twelveHourFormat = false;
    } else {
      setTime(DateTime.now());
    }
  });

  void changeHoursFormat(value) => setState(() {
    hourFormat = hourFormat == 24 ? 13: 24;
    if (fromAllDay == false) {
      twelveHourFormat = !twelveHourFormat;
    }
    hoursController.clear();
  });

  void setTime(DateTime date) {
    hoursController.text = date.hour.toString().padLeft(2, '0');
    minutesController.text = date.minute.toString().padLeft(2, '0');
  }

  void addTimeToTime(DateTime date) {
    var dateNow = DateTime.now();
    
    var newDate = DateTime(
      dateNow.year,
      dateNow.month,
      dateNow.day,
      dateNow.hour + date.hour,
      dateNow.minute + date.minute
    );
    if (!fromAllDay) {
      setTime(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchWithLabel(
          state: fromAllDay,
          label: "Без часу",
          callback: changeFromAllDay,
        ),
        const SizedBox(height: 5),
        ClockContainerWidget(
          hourInput:NumberInput(
            name: "Години",
            maxValue: hourFormat,
            controller: hoursController,
            enabled: !fromAllDay
          ),
          minuteInput: NumberInput(
            name: "Хвилини",
            maxValue: 60,
            controller: minutesController,
            enabled: !fromAllDay
          ),
          twelveHourFormat: twelveHourFormat
        ),
        const SizedBox(height: 5),
        SwitchWithLabel(
          state: twelveHourFormat,
          label: "AM/PM",
          callback: changeHoursFormat,
        ), 
        const SizedBox(height: 5),   
        TimeTemplatesContainer(
          children: [
            TimeTemplateItem(callback: addTimeToTime,hour: 1,minutes: 0),
            TimeTemplateItem(callback: addTimeToTime,hour: 0,minutes: 30),
            TimeTemplateItem(callback: addTimeToTime,hour: 12,minutes: 0),
            TimeTemplateItem(callback: addTimeToTime,hour: 3,minutes: 45),
          ],
        )  
      ],
    );
  }
}

