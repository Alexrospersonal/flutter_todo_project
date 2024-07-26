import 'package:flutter/material.dart';

abstract interface class TimeController {
  final int hour;
  final int minute;
  final int amPm;

  TimeController({required this.hour, required this.minute, required this.amPm});
}

class Time12Controller implements TimeController{
  @override
  final int hour;
  @override
  final int minute;
  @override
  final int amPm;

  Time12Controller._({required this.amPm, required this.hour, required this.minute});

  TimeOfDay getTimeOfDay() {
    int formatedHour = amPm == 0 ? hour : hour + 12;
    return TimeOfDay(hour: formatedHour, minute: minute);
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

class Time24Controller implements TimeController{
  @override
  final int hour;
  @override
  final int minute;
  @override
  final int amPm;

  Time24Controller._({required this.hour, required this.minute, required this.amPm});

  TimeOfDay getTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  factory Time24Controller({required int hour, required int minute}) {
    int clampedHour = hour;
    int clampedMinute = minute;

    if (minute > 59) {
      clampedMinute = minute - 60;
      clampedHour += 1;
    }
    if (clampedHour > 23) {
      clampedHour = 0;
    }

    return Time24Controller._(
      hour: clampedHour,
      minute: clampedMinute,
      amPm: 0
    );
  }
}

abstract class TimeControllerFactory {
  TimeController createTimeController(int hour, int minute, {int amPm = 0});
}

class Time12ControllerFactory implements TimeControllerFactory {
  @override
  TimeController createTimeController(int hour, int minute, {int amPm = 0}) {
    return Time12Controller(hour: hour, minute: minute, amPm: amPm);
  }
}

class Time24ControllerFactory implements Time12ControllerFactory {
  @override
  TimeController createTimeController(int hour, int minute, {int amPm = 0}) {
    return Time24Controller(hour: hour, minute: minute);
  }
}