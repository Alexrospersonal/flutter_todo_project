import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/calendar_page/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CalendarWidget(),
          )),
          // Expanded(child: Placeholder())
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  final void Function(DateTime)? changeDate;

  const CalendarWidget({super.key, this.changeDate});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;

            if (widget.changeDate != null) {
              widget.changeDate!(selectedDay);
            }
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(formatButtonVisible: false),
        calendarBuilders: CalendarBuilders());
  }
}
