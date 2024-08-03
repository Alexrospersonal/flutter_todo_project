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
  List<bool>? repetlyDates;
  Duration? duration;
  List<DateTime>? reminders;

  TaskListItemData({
    required this.id,
    required this.name
    });

  void addCategory(String category) {
    this.category = category;
  }

  void addColor(Color color) {
    this.color = color;
  }

  void addDate(DateTime date) {
    this.date = date;
  }

  void addDuration(Duration duration) {
    this.duration = duration;
  }

  void addrepetlyDate(List<bool> list) {
    repetlyDates = list;
  }

  void addRemiders(List<DateTime> newReminders) {
    reminders = newReminders;
  }

  List<String>? repeatlyDaysAsStrings(S s) {
    final dateFormat = DateFormat('EEE');

    final List<String> formattedDates = repetlyDates != null
      ? repetlyDates!.asMap().entries
          .where((entry) => entry.value) // Фільтруємо записи, де значення true
          .map((entry) {
            final date = DateTime.utc(2024, 1, 1).add(Duration(days: entry.key));
            return dateFormat.format(date); // Форматуємо дату
          })
          .toList() // Перетворюємо результат в список
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
    DateFormat dateFormat = DateFormat("HH:mm dd/MM/yyyy");
    if (date != null) {
      return dateFormat.format(date!);
    }
    return null;
  }

  String getFormatedStartIn(Duration? startIn, S s) {
    if (date != null) {
      DateTime now = DateTime.now();
      var startIn = date!.difference(now);

      int day = startIn.inDays;
      int hour = startIn.inHours % 24;
      int minute = startIn.inMinutes % 60;
      String text = "";

      text += day != 0 ? "$day${s.shortDay} " : "";
      text += hour != 0 ? "$hour${s.shortHour} " : "";
      text += minute != 0 ? "$minute${s.shortMinute}" : "";

      return text;
    }
    return s.none;
  }

  bool isRemidresExists() {
    return reminders != null ? true : false;
  }
}

TaskListItemData buildTask(String taskName, List<bool> repeatlyDays, bool important, Color? color) {
  var task1 = TaskListItemData(id: 1, name: taskName);
  if (important) {
    task1.important = true;
  }
  if (color != null) {
    task1.color = color;
  }
  task1.addCategory("Home");
  task1.addDate(DateTime(2024, 9, 12, 17, 33));
  task1.addrepetlyDate(repeatlyDays);
  task1.addDuration(const Duration(hours: 7));
  task1.addRemiders([DateTime(2024, 8, 12, 17, 33)]);

  return task1;
}
