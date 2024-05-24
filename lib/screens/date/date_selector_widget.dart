import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:flutter_todo_project/screens/date/select_day_widget.dart';
import 'package:flutter_todo_project/screens/date/select_month_widget.dart';
import 'package:flutter_todo_project/screens/date/select_year_widget.dart';
import 'package:provider/provider.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({super.key});

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  final ValueNotifier<bool> _isDayViewVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isMonthViewVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isYearViewVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    int day = context.watch<DateModel>().day;
    int month = context.watch<DateModel>().month;
    int year = context.watch<DateModel>().year;

    return Column(
      children: [
        DateSelectButtonsWidget(
            isDayViewVisible: _isDayViewVisible,
            isMonthViewVisible: _isMonthViewVisible,
            isYearViewVisible: _isYearViewVisible,
            day: day,
            month: month,
            year: year),
        ValueListenableBuilder<bool>(
          valueListenable: _isDayViewVisible,
          builder: (context, value, child) {
            return value ? const SelectDayWidget() : const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isMonthViewVisible,
          builder: (context, value, child) {
            return value ? const SelectMonthWidget() : const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder(
          valueListenable: _isYearViewVisible,
          builder: (context, value, child) {
            return value ? const SelectYearWidget() : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

class DateSelectButtonsWidget extends StatelessWidget {
  const DateSelectButtonsWidget({
    super.key,
    required ValueNotifier<bool> isDayViewVisible,
    required ValueNotifier<bool> isMonthViewVisible,
    required ValueNotifier<bool> isYearViewVisible,
    required this.day,
    required this.month,
    required this.year,
  })  : _isDayViewVisible = isDayViewVisible,
        _isMonthViewVisible = isMonthViewVisible,
        _isYearViewVisible = isYearViewVisible;

  final ValueNotifier<bool> _isDayViewVisible;
  final ValueNotifier<bool> _isMonthViewVisible;
  final ValueNotifier<bool> _isYearViewVisible;
  final int day;
  final int month;
  final int year;

  @override
  Widget build(BuildContext context) {
    String dayOfWeek = context.watch<DateModel>().getDayOfWeekAsString();

    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              _isDayViewVisible.value = !_isDayViewVisible.value;
              _isMonthViewVisible.value = false;
              _isYearViewVisible.value = false;
            },
            child: Text('$dayOfWeek: $day')),
        ElevatedButton(
            onPressed: () {
              _isDayViewVisible.value = false;
              _isMonthViewVisible.value = !_isMonthViewVisible.value;
              _isYearViewVisible.value = false;
            },
            child: Text(months[month - 1])),
        ElevatedButton(
            onPressed: () {
              _isDayViewVisible.value = false;
              _isMonthViewVisible.value = false;
              _isYearViewVisible.value = !_isYearViewVisible.value;
            },
            child: Text('Year: $year')),
      ],
    );
  }
}
