import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget<T extends CalendarState> extends StatefulWidget {
  final void Function(DateTime)? changeDate;
  final DateTime? recurringEndDate;
  final DateTime? focusedDay;
  final List<bool> weekdays;

  const CalendarWidget({
    super.key,
    required this.weekdays,
    this.focusedDay,
    this.changeDate,
    this.recurringEndDate,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState<T>();
}

class _CalendarWidgetState<T extends CalendarState>
    extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();

  bool isHighlighted(DateTime day) {
    if (widget.recurringEndDate == null) {
      if (day.isAfter(_selectedDay)) {
        return widget.weekdays[day.weekday - 1];
      }
      return false;
    }

    if (day.isBefore(_selectedDay) || day.isAfter(widget.recurringEndDate!)) {
      return false;
    }
    return widget.weekdays[day.weekday - 1];
  }

  DateTime getFocusedTime(DateTime? startDate) {
    if (widget.focusedDay == null) {
      return startDate ?? DateTime.now();
    }
    return widget.focusedDay!;
  }

  @override
  Widget build(BuildContext context) {
    var startDate = context.watch<T>().taskDateTime;

    if (startDate == null) {
      _selectedDay = DateTime.now();
    } else {
      _selectedDay = startDate;
    }
    return TableCalendar(
        shouldFillViewport: true,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: getFocusedTime(startDate),
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
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          headerPadding: EdgeInsets.all(3),
        ),
        calendarStyle: const CalendarStyle(
            cellMargin: EdgeInsets.all(5), tablePadding: EdgeInsets.all(0)),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (widget.recurringEndDate != null &&
                isSameDay(widget.recurringEndDate, day)) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 190, 121, 16),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${day.day}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            } else if (isHighlighted(day)) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 200, 118),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${day.day}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                '${day.day}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: greyColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${day.day}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).canvasColor),
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            if (widget.recurringEndDate != null &&
                isSameDay(widget.recurringEndDate, day)) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 190, 121, 16),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${day.day}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 255, 200, 118),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${day.day}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: greyColor),
              ),
            );
          },
        ));
  }
}
