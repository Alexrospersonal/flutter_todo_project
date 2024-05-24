import 'package:flutter/material.dart';

class DateModel extends ChangeNotifier {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  final int currentYear = DateTime.now().year;

  void changeDay(int newDay) {
    day = newDay;
    notifyListeners();
  }

  void changeMonth(int newMonth) {
    month = newMonth;
    notifyListeners();
  }

  void changeYear(int newYear) {
    year = newYear;
    notifyListeners();
  }

  DateTime getDateTime() {
    return DateTime(year, month, day);
  }

  String getDayOfWeekAsString() {
    return daysOfWeek[getDateTime().weekday - 1];
  }

  String getFormatedDateAsString() {
    return 'Date: $day/${months[month - 1]}/$year';
  }

  List<int> getYearsList() {
    return List<int>.generate(12, (index) => currentYear + index);
  }
}

final List<String> months = [
  'Січень',
  'Лютий',
  'Березень',
  'Квітень',
  'Травень',
  'Червень',
  'Липень',
  'Серпень',
  'Вересень',
  'Жовтень',
  'Листопад',
  'Грудень'
];

List<String> daysOfWeek = [
  'Понеділок',
  'Вівторок',
  'Середа',
  'Четвер',
  'П\'ятниця',
  'Субота',
  'Неділя'
];
