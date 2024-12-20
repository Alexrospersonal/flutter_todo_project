import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatedTime {
  String hour;
  String minute;
  String amPm;

  FormatedTime(this.hour, this.minute, this.amPm);

  static FormatedTime getFormatedTime(DateTime? time, bool is24HourFormat) {
    if (time == null) {
      return FormatedTime("", "", "");
    }

    if (is24HourFormat) {
      return format24timeToClock(time);
    } else {
      return format12timeToClock(time);
    }
  }

  static FormatedTime format24timeToClock(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute =  time.minute.toString().padLeft(2, '0');

    return FormatedTime(hour, minute, "");
  }

  static FormatedTime format12timeToClock(DateTime time) {
    String formattedTime = DateFormat('hh:mm a').format(time);
    List<String> splitedFormatedTime = formattedTime.split(' ');
    List<String> timeSplited = splitedFormatedTime[0].split(":");
    
    return FormatedTime(timeSplited[0], timeSplited[1], splitedFormatedTime[1]);
  }

  static String getTaskTimeInfo(BuildContext context, DateTime time) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    if (is24HourFormat) {
      return DateFormat(DateFormat.HOUR24_MINUTE).format(time);
    }
    return DateFormat('hh:mm a').format(time);
  }
}