import 'package:flutter/material.dart';

abstract interface class UpdatedNotifier {
  bool canEnabled = false;
  bool isEnabled = false;
  void update<T extends UpdatedNotifier>(T state);
}

class RepeatlyNotifier extends ChangeNotifier implements UpdatedNotifier {
  @override
  bool canEnabled = false;
  @override
  bool isEnabled = false;
  List<bool> repeatOfDays = List.generate(7, (idx) => false);

  void setIsRepeatOfDays(bool state) {
    if (canEnabled) {
      isEnabled = state;
      resetWeekDays(state);
    }
    notifyListeners();
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
  void update<T extends UpdatedNotifier>(T state) {
    canEnabled = state.canEnabled;
    if (state.canEnabled == false) {
      isEnabled = false;
      resetWeekDays(state.canEnabled);
      notifyListeners();
    }
  }
}

class LastDayOfRepeatNotifier extends ChangeNotifier
    implements UpdatedNotifier {
  @override
  bool canEnabled = false;
  @override
  bool isEnabled = false;
  DateTime? lastDate;

  void setIsLastDayOfRepeat(bool state) {
    if (canEnabled) {
      isEnabled = state;
      notifyListeners();
    }
  }

  @override
  void update<T extends UpdatedNotifier>(T state) {
    canEnabled = state.isEnabled;
    if (state.isEnabled == false) {
      isEnabled = false;
      notifyListeners();
    }
  }
}

class RepeatInTimeNotifier extends ChangeNotifier implements UpdatedNotifier {
  @override
  bool canEnabled = false;

  @override
  bool isEnabled = false;

  List<DateTime?> times = List.generate(4, (idx) => null);

  void setRepeatInTime(bool state) {
    if (canEnabled) {
      isEnabled = state;
      notifyListeners();
    }
  }

  void setRepeatTime(DateTime? time, int idx) {
    if (isEnabled) {
      times[idx] = time;
      times = List.from(times);
      notifyListeners();
    }
  }

  @override
  void update<T extends UpdatedNotifier>(T state) {
    canEnabled = state.isEnabled;
    if (state.isEnabled == false) {
      isEnabled = false;
      notifyListeners();
    }
  }
}
