import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/clock_number_input.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/time_picker_widget/double_dot_time_divider.dart';

class TaskDurationPickerWidget extends StatefulWidget {
  const TaskDurationPickerWidget({
    super.key,
  });

  @override
  State<TaskDurationPickerWidget> createState() => _TaskDurationPickerWidgetState();
}

class _TaskDurationPickerWidgetState extends State<TaskDurationPickerWidget> {
  bool isActive = false;
  bool notificatioOfEnd = false;
  int hourFormat = 24;

  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime? endDate;

  void switchIsActiveStatus(bool status) {
    setState(() {
      isActive = status;
    });
  }

  void swithEndOfNotication(bool status) {
    setState(() {
      notificatioOfEnd = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Header Row
        const Row(
          children: [
            Text("Твивалість завдання",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        // Row with switchers
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SwitchWithLabel(
              state: isActive,
              label: isActive ? "Вимкнути\nтривалість" : "Увімкнути\nтривалість",
              callback: switchIsActiveStatus
            ),
            SwitchWithLabel(
              state: notificatioOfEnd,
              label: "Сповіщати\nпро кінець",
              callback: swithEndOfNotication
            ),
          ],
        ),
        // Row with times
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hours
            Flexible(
              flex: 1,
              child: NumberInput(
                name: "Години",
                maxValue: hourFormat,
                controller: hoursController,
                enabled: isActive,
                onChanged: (val) {},
              )
            ),
            const Flexible(
              flex: 0,
              child: DoubleDotTimeDivider()
              ),
            Flexible(
              flex: 1,
              child: NumberInput(
                name: "Хвилини",
                maxValue: 60,
                controller: minutesController,
                enabled: isActive,
                onChanged: (val) {},
              )
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Початок:\n${startDate.day}/${startDate.month}/${startDate.year} ${startDate.hour}:${startDate.minute}",
              style: const TextStyle(
                height: 1,
                fontSize: 16
              ),
            ),
            Text(
              "Кінець:\n${startDate.day}/${startDate.month}/${startDate.year} ${startDate.hour}:${startDate.minute}",
              textAlign: TextAlign.end,
              style: const TextStyle(
                height: 1,
                fontSize: 16,
              ),
            )
          ],
        ),
      ],
    );
  }
}