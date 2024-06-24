import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/date_selector/date_selector_widget.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/day_in_week_widget/days_in_week_label.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/day_in_week_widget/set_end_dialog_button.dart';

class DaysInWeekPickerWidget extends StatefulWidget {
  const DaysInWeekPickerWidget({ super.key });

  @override
  State<DaysInWeekPickerWidget> createState() => _DaysInWeekPickerWidgetState();
}

class _DaysInWeekPickerWidgetState extends State<DaysInWeekPickerWidget> {
  final List<bool> selectedDays = List.generate(7, (index) => false);
  final List<String> weekDays = ['Пн','Вт','Ср','Чт','Пт','Сб','Нд',];

  bool isEndless = true;
  DateTime dateOfTheEnd = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 1);
  String dateOfTheEndText = "Без кінця";

  void changeDateOfEnd(DateTime date) {
    setState(() {
      dateOfTheEnd = date;
      dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
    });
  }

  void showEndOfRepeatDayDialog() {
    if (isEndless == false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
        builder:(context) {
          return DialogContainer(
            children: [
              InnerDialogContainer(
                title: "Дата завершення",
                child: SizedBox(
                  height: 350,
                  width: 300,
                  child: CalendarWidget(changeDate: changeDateOfEnd)
                )
              ),
              Positioned(
                left: 155-30,
                right: 155-30,
                bottom: -25,
                child: DoneButton(action: () {},)
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Виберіть дні повторення завдання",
          style: TextStyle(
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.normal
          ),
        ),
        const SizedBox(height: 10),
        // Row with days
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            weekDays.length,
            (index) {
              return DayInWeekLableWidget(dayName: weekDays[index], index: index, selectedDays: selectedDays,);
            }
          )           // DayInWeekLableWidget(dayName: "Пн",)
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SwitchWithLabel(
              state: !isEndless,
              label: "Додати кінцеву",
              callback: (value) => setState(() {
                isEndless = !isEndless;
                if (isEndless == false) {
                  dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
                } else {
                  dateOfTheEndText = "Без кінця";
                }
              })
            ),
            SetEndDialogButton(
              state: isEndless,
              text: dateOfTheEndText,
              callback: showEndOfRepeatDayDialog,
            ),
          ],
        ),
      ]
    );
  }
}