import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/enabled_notifier_interface.dart';

class TaskTimeNotifier extends ChangeNotifier implements IsEnabledNotifier {
  @override
  bool canEnabled = false;

  @override
  bool isEnabled = false;

  DateTime? taskDateTime;

  bool setIsEnabled(bool state) {
    if (canEnabled) {
      isEnabled = state;
      taskDateTime ??= DateTime.now();
      resetTime(state);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  setTaskDateTime(DateTime time) {
    if (isEnabled) {
      taskDateTime = time;
      notifyListeners();
    }
  }

  resetTime(bool state) {
    if (!state) {
      taskDateTime = null;
    }
  }

  @override
  void update<T extends IsEnabledNotifier>(T state) {
    canEnabled = state.canEnabled;
    if (state.canEnabled == false) {
      isEnabled = false;
      resetTime(state.canEnabled);
    }
    notifyListeners();
  }
}
