import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';


abstract class CalendarState {
  DateTime? taskDateTime;

  void setDate(DateTime newDate);
}

class TaskState extends ChangeNotifier implements CalendarState {
  String title = "";
  String? note;
  Category category;
  Color color = taskColors[0];
  bool important = false;

  bool hasDate = false;
  bool hasTime = false;
  
  @override
  DateTime? taskDateTime;

  bool isRecurring = false;
  List<bool> recurringDays = List.generate(7, (index) => false);

  // TODO: додати функцію зміни стану для виклику вибору кінця повторнення
  bool endOfRecurring = false;
  DateTime? recurringEndDate;

  bool hasDuration = false;
  DateTime? taskDuration;
  bool notifyAboutTheEndOfTheTask = false;

  Set<DateTime> notification = <DateTime>{};

  TaskState({required this.category});

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
    if (hasDate) {
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
    hasDate = true;
    notifyListeners();
  }

  void setTime(int hour, int minutes) {
    if (taskDateTime != null) {
      hasTime = true;
      taskDateTime = DateTime(
        taskDateTime!.year,
        taskDateTime!.month,
        taskDateTime!.day,
        hour,
        minutes
      );
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

  void setMinutes(int minutes) {
    taskDateTime = DateTime(
      taskDateTime!.year,
      taskDateTime!.month,
      taskDateTime!.day,
      taskDateTime!.hour,
      minutes
    );
    notifyListeners();
  }
  
  void setHasDate(bool newState) {
    if (newState == false) {
      taskDateTime = null; // або DateTime.now() або інше значення за замовчуванням
      hasTime = false;
      isRecurring = false;
      resetRecurringDays();
    } else {
      taskDateTime = DateTime.now();
    }
    
    hasDate = newState;
    notifyListeners();
  }

  bool setHasTime(bool newState) {
    if (hasDate) {
      hasTime = newState;
      notifyListeners();
      return true;
    }
    return false;
  }

  void resetRecurringDays() {
    recurringDays = List.generate(7, (index) => false);
  }

}

