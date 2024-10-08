import 'dart:ui';

import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';

class TaskItemDataBuilder {
  final TaskEntity task;
  TaskListItemData? taskData;

  TaskItemDataBuilder({required this.task});

  void validateTaskData() {
    if (taskData == null) {
      throw Exception("first need call createTaskData");
    }
  }

  TaskItemDataBuilder createTaskData() {
    taskData = TaskListItemData(id: task.id, name: task.title);
    return this;
  }

  TaskItemDataBuilder addCategory() {
    if (task.category.value != null) {
      taskData?.category = task.category.value.toString();
    }
    return this;
  }

  TaskItemDataBuilder addColor() {
    if (task.color != null) {
      taskData?.color = Color(task.color!);
    }
    return this;
  }

  TaskItemDataBuilder addDate() {
    if (task.taskDate != null) {
      taskData?.date = task.taskDate;
    }
    return this;
  }

  TaskItemDataBuilder addIsOriginal() {
    if (task.originalTask.value != null) {
      taskData?.isCopy = true;
    }
    return this;
  }

  TaskItemDataBuilder addNotificationId() {
    if (task.notificationId != null) {
      taskData?.notificationId = task.notificationId;
    }
    return this;
  }

  TaskItemDataBuilder addRepeatedData() {
    if (task.hasRepeats && task.isCopy) {
      task.originalTask.loadSync();
      var originalTask = task.originalTask.value;
      originalTask!.repeatedTask.loadSync();

      var repeatedTaskEntity = originalTask.repeatedTask.first;

      taskData?.repeatedDuringDay = repeatedTaskEntity.repeatDuringDay;
      taskData?.endDate = repeatedTaskEntity.endDateOfRepeatedly;

      taskData?.repetlyDates = List<bool>.generate(
          7,
          (int index) =>
              repeatedTaskEntity.repeatDuringWeek!.contains(index + 1)
                  ? true
                  : false);
    }

    return this;
  }

  TaskListItemData build() {
    validateTaskData();

    return taskData!;
  }
}
