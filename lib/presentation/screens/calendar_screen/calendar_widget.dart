
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget<T extends CalendarState> extends StatefulWidget {
  final void Function(DateTime)? changeDate;

  const CalendarWidget({super.key, this.changeDate});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState<T>();
}

class _CalendarWidgetState<T extends CalendarState> extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Selector<T, DateTime?>(
      selector: (context, taskState) => taskState.taskDateTime,
      builder: (context, value, child) {

        if (value == null) {
          _selectedDay = DateTime.now();
        } else {
          _selectedDay = value;
        }

        return TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: value ?? DateTime.now(),
          // rangeStartDay: value ?? DateTime.now(),
          // rangeEndDay: DateTime(2024, 7, 13),
          rowHeight: 36,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
              context.read<T>().setDate(selectedDay);

              _selectedDay = selectedDay;
              // _focusedDay = focusedDay;

              if (widget.changeDate != null) {
                widget.changeDate!(selectedDay);
              }
          },
          // onPageChanged: (focusedDay) {
          //   _focusedDay = focusedDay;
          // },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            headerPadding: EdgeInsets.all(3)
          ),
          calendarStyle: const CalendarStyle(
            cellMargin: EdgeInsets.all(0),
          ),
          calendarBuilders: const CalendarBuilders()
        );
      },
    );
  }
}
