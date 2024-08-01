import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:intl/intl.dart';

class TaskListItemData {
  bool important = false;
  String? category;
  String name;
  DateTime? date;
  List<bool>? repetlyDates;
  Duration? duration;
  List<DateTime>? reminders;

  TaskListItemData({required this.name});

  void addCategory(String category) {
    this.category = category;
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

  List<String>? get repeatlyDaysAsStrings {
    final dateFormat = DateFormat('EEE');

    if (repetlyDates != null) {
      List<String> shortWeekdays = List.generate(7, (index) {
        final date = DateTime.utc(2024, 1, 1).add(Duration(days: index));
        return dateFormat.format(date);
      });

      return shortWeekdays.reversed.toList();
    }
    return null;
  }

  Duration? get startIn {
    if (date != null) {
      DateTime now = DateTime.now();

      return date!.difference(now);
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
}

TaskListItemData buildTask() {
  var task1 = TaskListItemData(name: "Filling my soul with butter and beer");
  task1.important = true;
  task1.addCategory("Home");
  task1.addDate(DateTime(2024, 9, 12, 17, 33));
  task1.addrepetlyDate([true, true, true, false, false, false, true]);
  task1.addDuration(const Duration(hours: 7));
  task1.addRemiders([DateTime(2024, 8, 12, 17, 33)]);

  return task1;
}
