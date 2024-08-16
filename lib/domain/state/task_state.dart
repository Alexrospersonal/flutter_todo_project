import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

abstract class CalendarState implements UpdatedNotifier {
  DateTime? taskDateTime;

  void setDate(DateTime newDate);
}

class TaskState extends ChangeNotifier implements CalendarState {
  String title = "";
  String? note;
  Category category;
  Color color = taskColors[0];
  bool important = false;

  @override
  bool isEnabled = false;

  @override
  bool canEnabled = false;
  bool hasTime = false;

  @override
  DateTime? taskDateTime;

  bool isRecurring = false;
  List<bool> recurringDays = List.generate(7, (index) => false);

  bool endOfRecurring = false;
  DateTime? recurringEndDate;

  // TODO: можливо замінити DateTime на Duration
  bool hasDuration = false;
  DateTime? taskDuration;
  bool notifyAboutTheEndOfTheTask = false;

  Set<DateTime> notification = <DateTime>{};

  TaskState({required this.category});

  bool setHasDuration(bool state) {
    if (taskDateTime != null && hasTime) {
      hasDuration = state;

      DateTime now = DateTime.now();
      taskDuration = DateTime(now.year, now.month, now.day, 0, 0);

      notifyListeners();
      return true;
    }
    return false;
  }

  void setNotifyAboutTheEndOfTheTask(bool state) {
    if (hasDuration) {
      notifyAboutTheEndOfTheTask = state;
      notifyListeners();
    }
  }

  void setRecurringEndDate(DateTime endDate) {
    if (recurringEndDate != null && recurringEndDate!.compareTo(endDate) == 0) {
      endOfRecurring = false;
      recurringEndDate = null;
    } else {
      recurringEndDate = endDate;
      endOfRecurring = true;
    }
    notifyListeners();
  }

  bool setEndOfRecurring(bool state) {
    if (isRecurring) {
      endOfRecurring = state;
      recurringEndDate = null;
      notifyListeners();
    }
    return endOfRecurring;
  }

  bool setIsRecurring(bool state) {
    if (canEnabled) {
      isRecurring = state;
      if (!state) {
        recurringDays = List.generate(7, (index) => false);
        recurringEndDate = null;
        endOfRecurring = false;
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void setRecurringDays(int selectedDay) {
    if (isRecurring) {
      recurringDays[selectedDay] = !recurringDays[selectedDay];
      recurringDays = recurringDays.sublist(0);
      notifyListeners();
    }
  }

  void setImportant() {
    important = !important;
    notifyListeners();
  }

  void setColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    category = newCategory;
    notifyListeners();
  }

  @override
  void setDate(DateTime newDate) {
    taskDateTime = newDate;
    canEnabled = true;
    notifyListeners();
  }

  void setTime(int hour, int minutes) {
    if (taskDateTime != null) {
      hasTime = true;
      taskDateTime = DateTime(taskDateTime!.year, taskDateTime!.month,
          taskDateTime!.day, hour, minutes);
      notifyListeners();
    }
  }

  void setHour(int hour) {
    taskDateTime = DateTime(
      taskDateTime!.year,
      taskDateTime!.month,
      taskDateTime!.day,
      hour,
      taskDateTime!.minute,
    );
    notifyListeners();
  }

  void setMinute(int minutes) {
    taskDateTime = DateTime(taskDateTime!.year, taskDateTime!.month,
        taskDateTime!.day, taskDateTime!.hour, minutes);
    notifyListeners();
  }

  void setDurationHour(int hour) {
    taskDuration = DateTime(
      taskDuration!.year,
      taskDuration!.month,
      taskDuration!.day,
      hour,
      taskDuration!.minute,
    );
    notifyListeners();
  }

  void setDurationMinute(int minute) {
    taskDuration = DateTime(
      taskDuration!.year,
      taskDuration!.month,
      taskDuration!.day,
      taskDuration!.hour,
      minute,
    );
    notifyListeners();
  }

  void setHasDate(bool newState) {
    if (newState == false) {
      taskDateTime =
          null; // або DateTime.now() або інше значення за замовчуванням
      taskDuration = null;
      hasTime = false;
      isRecurring = false;
      hasDuration = false;
      resetRecurringDays();
    } else {
      taskDateTime = DateTime.now();
    }

    canEnabled = newState;
    notifyListeners();
  }

  bool setHasTime(bool newState) {
    if (canEnabled) {
      hasTime = newState;
      if (!newState) {
        taskDuration = null;
        hasDuration = false;
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void resetRecurringDays() {
    recurringDays = List.generate(7, (index) => false);
  }

  @override
  void update<T extends UpdatedNotifier>(T state) {
    // TODO: implement update
  }
}
