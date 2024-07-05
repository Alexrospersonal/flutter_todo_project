import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_alert_dialog.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/time_template_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/time_template_item.dart';
import 'package:provider/provider.dart';

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

  // void changeFromAllDay(value) => setState(() {
  //   fromAllDay = !fromAllDay;
  //   if (fromAllDay) {
  //     hoursController.clear();
  //     minutesController.clear();
  //     twelveHourFormat = false;
  //   } else {
  //     setTime(DateTime.now());
  //   }
  // });

    void changeFromAllDay(value) {
      bool result = Provider.of<TaskState>(context, listen: false).setHasTime(value);

      if (!result) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const CustomAlerDialog(errorMessage: 'Виберіть спочатку дату',);
          },
        );
      } 
    }

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

  // TODO: Додати дані з контролерів до стану
  // та відповідно виправити шаблони для часу
  // протестувати та прибрати лишнє

  void onChangedHours(String hour) {

  }

  void onChangedMinutes(String minutes) {

  }

  @override
  Widget build(BuildContext context) {
    return Selector<TaskState, bool>(
      selector: (context, state) => state.hasTime,
      builder: (context, hasTime, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchWithLabel(
                state: hasTime,
                label: "Додати час",
                callback: changeFromAllDay,
              ),
              const SizedBox(height: 5),
              ClockContainerWidget(
                hourInput:NumberInput(
                  name: "Години",
                  maxValue: hourFormat,
                  controller: hoursController,
                  enabled: hasTime,
                  onChanged: onChangedHours,
                ),
                minuteInput: NumberInput(
                  name: "Хвилини",
                  maxValue: 60,
                  controller: minutesController,
                  enabled: hasTime,
                  onChanged: onChangedMinutes,
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
          ),
        );
      },
    );
  }
}


