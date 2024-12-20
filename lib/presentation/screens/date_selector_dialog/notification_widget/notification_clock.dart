import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/am_pm_toggle_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_container.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';

class NotificationClockWidget extends StatefulWidget {
  const NotificationClockWidget({
    super.key,
  });

  @override
  State<NotificationClockWidget> createState() => _NotificationClockWidgetState();
}

class _NotificationClockWidgetState extends State<NotificationClockWidget> {
  bool fromAllDay = false;
  bool twelveHourFormat = false;
  int hourFormat = 24;
  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TimePickerInputsContainerWidget(
      hourInput:NumberInput(
        name: "Години",
        maxValue: hourFormat,
        controller: hoursController,
        enabled: true,
        onChanged: () {},
      ),
      minuteInput: NumberInput(
        name: "Хвилини",
        maxValue: 60,
        controller: minutesController,
        enabled: true,
        onChanged: () {},
      ),
      amPmToggleInput: const AmPmToggleContainer(
        isSelected: [],
      ),
      twelveHourFormat: twelveHourFormat,
    );
  }
}
