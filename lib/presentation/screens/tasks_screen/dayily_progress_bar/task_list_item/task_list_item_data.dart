import 'dart:ui';

import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:intl/intl.dart';

class TaskListItemData {
  int id;
  String name;
  Color? color;

  bool important = false;
  String? category;
  DateTime? date;
  bool hasTime = false;
  DateTime? endDate;
  List<bool>? repetlyDates;
  List<DateTime?>? repeatedDuringDay;
  Duration? duration;
  List<DateTime>? reminders;
  bool isCopy = false;
  int? notificationId;

  TaskListItemData({required this.id, required this.name});

  List<String>? repeatlyDaysAsStrings(S s) {
    final dateFormat = DateFormat('EEE');

    final List<String> formattedDates = repetlyDates != null
        ? repetlyDates!
            .asMap()
            .entries
            .where(
                (entry) => entry.value) // Фільтруємо записи, де значення true
            .map((entry) {
            final date =
                DateTime.utc(2024, 1, 1).add(Duration(days: entry.key));
            return dateFormat.format(date); // Форматуємо дату
          }).toList() // Перетворюємо результат в список
        : [];

    if (formattedDates.length == 7) {
      return [s.week];
    }

    return formattedDates.isNotEmpty ? formattedDates : null;
  }

  Duration? get startIn {
    if (date != null) {
      DateTime now = DateTime.now();

      return date!.difference(now);
    }
    return null;
  }

  String? getFomatedDate() {
    DateFormat dateFormat =
        hasTime ? DateFormat("dd/MM/yyyy HH:mm") : DateFormat("dd/MM/yyyy");

    // DateFormat dateFormat = DateFormat("HH:mm dd/MM/yyyy");
    if (date != null) {
      return dateFormat.format(date!);
    }
    return null;
  }

  String getFormatedStartIn(Duration? startIn, S s) {
    if (date != null) {
      DateTime now = DateTime.now();
      if (date!.isBefore(now) && hasTime == true) {
        return s.overdue;
      }

      if (!hasTime) {
        return s.duringTheDay;
      }

      var startIn = date!.difference(now);

      int day = startIn.inDays;
      int hour = startIn.inHours % 24;
      int minute = startIn.inMinutes % 60;
      String text = "";

      text += day != 0 ? "$day ${s.shortDay} " : "";
      text += hour != 0 ? "$hour ${s.shortHour} " : "";
      text += minute != 0 ? "$minute ${s.shortMinute}" : "";

      return "${s.startIn} $text";
    }
    return s.none;
  }

  bool isRemidresExists() {
    return reminders != null ? true : false;
  }
}
