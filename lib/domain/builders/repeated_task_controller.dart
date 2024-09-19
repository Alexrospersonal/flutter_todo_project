import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/task_stream_provider.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class RepeatedTaskController {
  final List<TaskListItemData> listItems = [];

  RepeatedTaskController();

  List<TaskListItemData> getRepeatedTaskData(
      List<RepeatedTaskEntity> repeatedTaskStream) {
    var weekday = DateTime.now().weekday;

    for (var repeatedEntity in repeatedTaskStream) {
      _isRepeatDuringWeek(repeatedEntity.repeatDuringWeek);

      bool isDaysMatch = repeatedEntity.repeatDuringWeek![weekday] == true;
      var isDuringDay = _isRepeatDuringDay(repeatedEntity.repeatDuringDay);
      var task = repeatedEntity.task.value;

      if (isDaysMatch && isDuringDay) {
        var times = _getExistingTimes(repeatedEntity.repeatDuringDay!);
        listItems.addAll(_buildItemDateWithTimes(task!, times));
      }

      if (isDaysMatch && !isDuringDay) {
        var taskData = buildTaskListItemData(task!);
        listItems.add(taskData);
      }
    }

    return listItems;
  }

  bool _isRepeatDuringWeek(List<bool>? repeatDuringWeek) {
    if (repeatDuringWeek == null) {
      throw Exception("repeatDuringWeek is not exists");
    }
    return true;
  }

  bool _isRepeatDuringDay(List<DateTime?>? repeatDuringDay) {
    if (repeatDuringDay == null ||
        repeatDuringDay.every((day) => day == null)) {
      return false;
    }
    return true;
  }

  List<DateTime?> _getExistingTimes(List<DateTime?> repeatDuringDay) {
    return repeatDuringDay.where((time) => time != null).toList();
  }

  List<TaskListItemData> _buildItemDateWithTimes(
      TaskEntity task, List<DateTime?> times) {
    List<TaskListItemData> items = [];

    for (var time in times) {
      var taskData = buildTaskListItemData(task);

      var date = taskData.date;
      var dateWithTime = date!.copyWith(hour: time!.hour, minute: time.minute);
      taskData.date = dateWithTime;

      items.add(taskData);
    }

    return items;
  }

  List<TaskListItemData> sortByFilters(List<TaskListItemData> items, TaskFilter filter) {
    var sorteredItems = items;
    
    switch (filter) {
      case TaskFilter.newest:
        sorteredItems.sort((a, b) => b.date!.compareTo(a.date!));
      case TaskFilter.oldest:
        sorteredItems.sort((a, b) => a.date!.compareTo(b.date!));
      case TaskFilter.isComing:
        sorteredItems.removeWhere((item) => item.date!.isBefore(DateTime.now()));
        sorteredItems.sort((a, b) => a.date!.compareTo(b.date!));
      case TaskFilter.important:
        sorteredItems = items.where((item) => item.important == true).toList();
      case TaskFilter.finished:
        break;
      case TaskFilter.outdated:
        sorteredItems = items.where((item) => item.date!.isBefore(DateTime.now())).toList();
    }

    return sorteredItems;
  }
}
