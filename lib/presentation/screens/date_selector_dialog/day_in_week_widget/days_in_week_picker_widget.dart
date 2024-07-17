import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/custom_alert_dialog.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/switch_with_label.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/date_selector_widget.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/day_in_week_widget/days_in_week_label.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/day_in_week_widget/set_end_dialog_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DaysInWeekPickerWidget extends StatefulWidget {
  const DaysInWeekPickerWidget({ super.key });

  @override
  State<DaysInWeekPickerWidget> createState() => _DaysInWeekPickerWidgetState();
}

class _DaysInWeekPickerWidgetState extends State<DaysInWeekPickerWidget> {
  final List<String> weekDays = ['Пн','Вт','Ср','Чт','Пт','Сб','Нд',];
  late TaskState taskState;
  bool isEndless = true;

  void switchRecurringStatus(bool state) {
    bool result = taskState.setIsRecurring(state);
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

  @override
  Widget build(BuildContext context) {
    taskState = Provider.of<TaskState>(context, listen: false);

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
        SwitchWithLabel(
          state: context.watch<TaskState>().isRecurring,
          label: "Додати повторення",
          callback: switchRecurringStatus
        ),
        WeekdaysContainer(taskState: taskState),
        const SizedBox(height: 5),
        RepetitionEndDateRowContainer(taskState: taskState)
      ]
    );
  }
}

class RepetitionEndDateRowContainer extends StatelessWidget {
  final TaskState taskState;

  const RepetitionEndDateRowContainer({
    super.key,
    required this.taskState
  });

  void showEndOfRepeatDayDialog(BuildContext providerContext) {
    bool result = taskState.isRecurring;

    if (result) {
      showDialog(
        context: providerContext,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
        builder:(context) {
          var res = providerContext.watch<TaskState>();

          return DialogForEndDateOfRepetition(providerState: res);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Selector<TaskState, bool>(
          selector: (context, state) => state.endOfRecurring,
          builder: (context, endOfRecurring, child) {
            return SwitchWithLabel(
              state: endOfRecurring,
              label: "Додати кінцеву",
              callback: (value) {
                var res = context.read<TaskState>().setEndOfRecurring(value);
                if (res) {
                  showEndOfRepeatDayDialog(context);
                }
              }
            );
          }, 
        ),
        Selector<TaskState, DateTime?>(
          selector: (context, state) => state.recurringEndDate,
          builder: (context, recurringEndDate, child) {
            return SetEndDialogButton(
            state: recurringEndDate != null ? false : true,
            text: recurringEndDate != null ? DateFormat('dd/MM/yyyy').format(recurringEndDate) : "Без кінця",
            callback: recurringEndDate != null ? showEndOfRepeatDayDialog: (BuildContext context) {},
            );
          },
        )
      ],
    );
  }
}

class WeekdaysContainer extends StatelessWidget {
  final TaskState taskState;

  const WeekdaysContainer({
    super.key,
    required this.taskState
    });


  void toggleDay(int index) {
    taskState.setRecurringDays(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = ['Пн','Вт','Ср','Чт','Пт','Сб','Нд',];

    return Selector<TaskState, List<bool>>(
      selector: (context, state) => state.recurringDays,
      builder:(context, recurringDays, child) => 
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          weekDays.length,
          (index) {
            return DayInWeekLableWidget(
              dayName: weekDays[index],
              index: index,
              selectedDay: recurringDays[index],
              callback: toggleDay,
            );
          }
        )
      ),
    );
  }
}

class DialogForEndDateOfRepetition extends StatelessWidget {
  const DialogForEndDateOfRepetition({
    super.key,
    required this.providerState,
  });

  final TaskState providerState;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: providerState,
      child: DialogContainer(
        children: [
          InnerDialogContainer(
            title: "Дата завершення",
            child: SizedBox(
              height: 350,
              width: 350,
              child: Selector<TaskState, DateTime?>(
                selector: (context, state) => state.recurringEndDate,
                builder: (context, recurringEndDate, child) {
                  var weekdays = context.read<TaskState>().recurringDays;
    
                  return CalendarWidget<TaskState>(
                    weekdays: weekdays,
                    recurringEndDate: recurringEndDate,
                    changeDate: (DateTime selectedDay) {
                      context.read<TaskState>().setRecurringEndDate(selectedDay);
                    }
                  );
                },
              )
            )
          ),
          Positioned(
            left: 155-30,
            right: 155-30,
            bottom: -25,
            child: DoneButton(action: () => true,)
          )
        ],
      ),
    );
  }
}

