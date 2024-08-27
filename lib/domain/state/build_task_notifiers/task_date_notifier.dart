import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/enabled_notifier_interface.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';

class TaskDateNotifier extends ChangeNotifier
    implements IsEnabledNotifier, CalendarState {
  @override
  bool canEnabled = true;

  @override
  bool isEnabled = false;

  @override
  DateTime? taskDateTime;

  void setHasDate(bool state) {
    isEnabled = state;
    if (state && taskDateTime == null) {
      taskDateTime = DateTime.now();
    }
    if (!state && taskDateTime != null) {
      taskDateTime = null;
    }
    notifyListeners();
  }

  @override
  void update<T extends IsEnabledNotifier>(T state) {}

  @override
  void setDate(DateTime newDate) {
    if (isEnabled) {
      taskDateTime = newDate;
    }
    notifyListeners();
  }
}
