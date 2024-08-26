import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/enabled_notifier_interface.dart';

class RepeatlyNotifier extends ChangeNotifier implements IsEnabledNotifier {
  @override
  bool canEnabled = false;
  @override
  bool isEnabled = false;
  List<bool> repeatOfDays = List.generate(7, (idx) => false);

  bool setIsRepeatOfDays(bool state) {
    if (canEnabled) {
      isEnabled = state;
      resetWeekDays(state);
      notifyListeners();

      return true;
    }
    notifyListeners();
    return false;
  }

  void resetWeekDays(bool state) {
    if (!state) {
      repeatOfDays = List.generate(7, (idx) => false);
    }
  }

  void setRepeatOfDays(int idx) {
    if (isEnabled) {
      repeatOfDays[idx] = !repeatOfDays[idx];
      repeatOfDays = List.from(repeatOfDays);
      notifyListeners();
    }
  }

  @override
  void update<T extends IsEnabledNotifier>(T state) {
    canEnabled = state.isEnabled;
    if (state.isEnabled == false) {
      isEnabled = false;
      resetWeekDays(state.isEnabled);
      notifyListeners();
    }
  }
}

class LastDayOfRepeatNotifier extends ChangeNotifier
    implements IsEnabledNotifier {
  @override
  bool canEnabled = false;
  @override
  bool isEnabled = false;
  DateTime? lastDate;

  // TODO: поправити логіку
  bool setIsLastDayOfRepeat(bool state) {
    if (canEnabled) {
      isEnabled = state;
      if (!state) {
        resetDate();
        notifyListeners();
        return false;
      }
      lastDate = DateTime.now();
      notifyListeners();
      return true;
    }

    return false;
  }

  void setLastDate(DateTime selectedDay) {
    if (lastDate != null && lastDate!.compareTo(selectedDay) == 0) {
      resetDate();
    } else {
      lastDate = selectedDay;
    }
    notifyListeners();
  }

  void resetDate() {
    lastDate = null;
  }

  @override
  void update<T extends IsEnabledNotifier>(T state) {
    canEnabled = state.isEnabled;
    if (state.isEnabled == false) {
      isEnabled = false;
      resetDate();
      notifyListeners();
    }
  }
}

class RepeatInTimeNotifier extends ChangeNotifier implements IsEnabledNotifier {
  @override
  bool canEnabled = false;

  @override
  bool isEnabled = false;

  List<DateTime?> times = List.generate(4, (idx) => null);

  void resetTimes(bool state) {
    if (!state) {
      times = List.generate(4, (idx) => null);
    }
  }

  bool setRepeatInTime(bool state) {
    if (canEnabled) {
      isEnabled = state;
      resetTimes(state);
      notifyListeners();
      return true;
    }
    return false;
  }

  void setRepeatTime(DateTime? time, int idx) {
    if (isEnabled) {
      times[idx] = time;
      times = List.from(times);
      notifyListeners();
    }
  }

  @override
  void update<T extends IsEnabledNotifier>(T state) {
    canEnabled = state.isEnabled;
    if (state.isEnabled == false) {
      isEnabled = false;
      resetTimes(state.isEnabled);
      notifyListeners();
    }
  }
}
