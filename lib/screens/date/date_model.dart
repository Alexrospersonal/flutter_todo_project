import 'package:flutter/material.dart';

class DateModel extends ChangeNotifier {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  void changeDay(int newDay) {
    day = newDay;
    notifyListeners();
  }
}
