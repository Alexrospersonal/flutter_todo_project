import 'package:flutter/material.dart';

class DateModel extends ChangeNotifier {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  bool timeless = true;

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

  void changeTime(int newHour, int newMinute) {
    hour = newHour;
    minute = newMinute;
    timeless = false;
    notifyListeners();
  }

  DateTime getDateTime() {
    return DateTime(year, month, day);
  }

  getTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String getDayOfWeekAsString() {
    return daysOfWeek[getDateTime().weekday - 1];
  }

  String getFormatedDateAsString() {
    return 'Date: $day/${months[month - 1]}/$year';
  }

  String getFormatedTimeAsString() {
    return 'Time: $hour:$minute';
  }

  List<int> getYearsList() {
    return List<int>.generate(12, (index) => currentYear + index);
  }

  int getDaysInMonth() {
    return DateTime(year, month + 1, 0).day;
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
