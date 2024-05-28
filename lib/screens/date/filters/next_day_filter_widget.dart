import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class NextDayFilter extends StatelessWidget {
  const NextDayFilter({super.key});

  // TODO: поправити функцію, може розбити на менші і винести в окремий обєкт
  void setNextDay(BuildContext context) {
    DateModel dateModel = Provider.of<DateModel>(context, listen: false);

    int nextDay = dateModel.day + 1;

    final daysInMonth =
        Provider.of<DateModel>(context, listen: false).getDaysInMonth();

    if (nextDay <= daysInMonth) {
      dateModel.changeDay(nextDay);
    } else {
      int nextMonth = dateModel.month + 1;
      if (nextMonth <= 12) {
        dateModel.changeMonth(nextMonth);
        dateModel.changeDay(1);
      } else {
        int nextYear = dateModel.year + 1;
        int lastYear =
            dateModel.getYearsList()[dateModel.getYearsList().length - 1];
        if (nextYear <= lastYear) {
          dateModel.changeYear(nextYear);
          dateModel.changeMonth(1);
          dateModel.changeDay(1);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setNextDay(context),
      child: const Text('Завтра'),
    );
  }
}
