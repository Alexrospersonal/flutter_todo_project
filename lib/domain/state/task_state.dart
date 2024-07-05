import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';


abstract class CalendarState extends ChangeNotifier {
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

  bool recurring = false;
  List<bool> recurringDays = List.generate(7, (index) => false);
  DateTime? recurringEndDate;

  bool hasDuration = false;
  DateTime? taskDuration;
  bool notifyAboutTheEndOfTheTask = false;

  Set<DateTime> notification = <DateTime>{};

  TaskState({required this.category});

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
        taskDateTime!.day,
        taskDateTime!.month,
        taskDateTime!.year,
        hour,
        minutes
      );
      notifyListeners();
    }
  }
  
  void setHasDate(bool newState) {
    if (newState == false) {
      taskDateTime = null; // або DateTime.now() або інше значення за замовчуванням
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

}

