import 'package:flutter/material.dart';

class Time12Controller {
  final int hour;
  final int minute;
  final int amPm;

  Time12Controller._({required this.amPm, required this.hour, required this.minute});

  TimeOfDay getTimeOfDay() {
    int formatedHour = amPm == 0 ? hour : hour + 12;
    return TimeOfDay(hour: formatedHour, minute: minute);
  }

  static int clampHour(int hour, int maxHour) {
    return hour > 12 ? 1 : hour; 
  }

  factory Time12Controller({required int hour, required int minute, required int amPm}) {
    int clampedHour = hour;
    int clampedMinute = minute;
    int clampedPeriod = amPm;

    if (minute > 59) {
      clampedMinute = minute - 60;
      clampedHour += 1;
    }
    if (clampedHour > 12) {
      clampedHour = 1;
      clampedPeriod = amPm == 0 ? 1 : 0;
    }

    return Time12Controller._(
      hour: clampedHour,
      minute: clampedMinute,
      amPm: clampedPeriod,
    );
  }
}
