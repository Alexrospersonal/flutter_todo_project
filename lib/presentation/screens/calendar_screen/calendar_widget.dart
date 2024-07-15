
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget<T extends CalendarState> extends StatefulWidget {
  final void Function(DateTime)? changeDate;
  final DateTime? recurringEndDate;
  final List<bool> weekdays;

  const CalendarWidget({
    super.key,
    required this.weekdays,
    this.changeDate,
    this.recurringEndDate,
    });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState<T>();
}

class _CalendarWidgetState<T extends CalendarState> extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();

  bool isHighlighted(DateTime day) {
    if (widget.recurringEndDate == null) {
      if (day.isAfter(_selectedDay)) {
        return widget.weekdays[day.weekday-1];
      }
      return false;
    }

    if (day.isBefore(_selectedDay) || day.isAfter(widget.recurringEndDate!)) {
      return false;
    }
    return widget.weekdays[day.weekday-1];
  }

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
              _selectedDay = selectedDay;

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
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              if (widget.recurringEndDate != null && isSameDay(widget.recurringEndDate, day)) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 190, 121, 16),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              else if (isHighlighted(day)) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 200, 118),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
            todayBuilder: (context, day, focusedDay) {
              
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
            outsideBuilder: (context, day, focusedDay) {
              if (widget.recurringEndDate != null && isSameDay(widget.recurringEndDate, day)) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 190, 121, 16),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          )
        );
      },
    );
  }
}
