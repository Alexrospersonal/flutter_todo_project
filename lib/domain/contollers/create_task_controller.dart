import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/builders/repeated_task_builder_director.dart';
import 'package:flutter_todo_project/domain/builders/task_builder.dart';
import 'package:flutter_todo_project/domain/builders/task_builder_director.dart';
import 'package:flutter_todo_project/domain/builders/task_entity_date_time_data_builder.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class CreateTaskController {
  final BuildContext context;

  CreateTaskController({required this.context});

  TaskBuilderDirector getTaskDirector(TaskDependencies dependencies) {
    var builder = TaskBuilder(dependencies: dependencies);
    return TaskBuilderDirector()..setBuilder(builder);
  }

  RepeatedTaskBuilderDirector getRepeatedTaskDirector(
      TaskDependencies dependencies) {
    var builder = RepeatedTaskBuilder(dependencies: dependencies);
    return RepeatedTaskBuilderDirector()..setBuilder(builder);
  }

  TaskEntity buildTask(TaskDependencies dependencies) {
    var director = getTaskDirector(dependencies);
    return director.build();
  }

  bool isWeekdays(TaskDependencies dependencies) {
    return dependencies.repeatlyNotifier.repeatOfDays.any((day) => day == true);
  }

  RepeatedTaskEntity? buildRepeatedTask(
      TaskEntity task, bool isWeekday, TaskDependencies dependencies) {
    var director = getRepeatedTaskDirector(dependencies);
    var repeatedTaskEntity = director.build();
    repeatedTaskEntity.task.value = task;
    return repeatedTaskEntity;
  }

  // TODO: Refactoring
  void saveTask() {
    TaskDependencies dependencies = TaskDependencies.fromContext(context);

    var task = buildTask(dependencies);
    var isWeekday = isWeekdays(dependencies);

    RepeatedTaskEntity? repeatedTaskEntity;

    if (task.hasRepeats && isWeekday) {
      repeatedTaskEntity = buildRepeatedTask(task, isWeekday, dependencies);
    }

    DbService.db.writeTxn(() async {
      await DbService.db.taskEntitys.put(task);
      await task.category.save();

      if (repeatedTaskEntity != null) {
        await DbService.db.repeatedTaskEntitys.put(repeatedTaskEntity);
        await repeatedTaskEntity.task.save();

        var nextDate = getNextDate(repeatedTaskEntity.repeatDuringWeek!);

        var isTimes =
            repeatedTaskEntity.repeatDuringDay?.any((time) => time != null);

        if (isTimes != null && isTimes == true) {
          var times = repeatedTaskEntity.repeatDuringDay!
              .where((time) => time != null)
              .toList();
          await createAndSaveAllCopiedTasks(times, nextDate, task);
        } else {
          await createAndSaveOneCopiedTask(task, nextDate);
        }
      }
    });
  }


  Future<void> createAndSaveAllCopiedTasks(
      List<DateTime?> times, DateTime nextDate, TaskEntity task) async {
    List<TaskEntity> copiestTasks = [];

    for (var time in times) {
      var dateWithTime = copyTimeToNewDate(nextDate, time!);
      var copiestTask = createCopyTaskFromRepeated(task, dateWithTime);
      copiestTasks.add(copiestTask);
    }

    await DbService.db.taskEntitys.putAll(copiestTasks);

    for (var copiestTask in copiestTasks) {
      addCategory(task, copiestTask);
      addOriginalTask(task, copiestTask);
    }
  }

  Future<void> createAndSaveOneCopiedTask(
      TaskEntity task, DateTime nextDate) async {
    var dateWithTime = copyTimeToNewDate(nextDate, task.taskDate!);
    var copiestTask = createCopyTaskFromRepeated(task, dateWithTime);

    await DbService.db.taskEntitys.put(copiestTask);

    addCategory(task, copiestTask);
    addOriginalTask(task, copiestTask);
  }

  // TODO: виправити логіку створення нової дати
  DateTime getNextDate(List<int> weekdays) {
    var currentWeekday = DateTime.now().weekday;

    int closesetDay = weekdays.firstWhere(
        (weekday) => weekday >= currentWeekday,
        orElse: () => weekdays[0]);

    var addDaysToDate = (currentWeekday - closesetDay + 7) % 7;
    return DateTime.now().add(Duration(days: addDaysToDate));
  }

  TaskEntity createCopyTaskFromRepeated(TaskEntity task, DateTime date) {
    var copiestTask = task.copyWith(taskDate: date);
    copiestTask.isCopy = true;

    return copiestTask;
  }

  void addCategory(TaskEntity task, TaskEntity copiestTask) {
    if (task.category.value != null) {
      copiestTask.category.value = task.category.value;
      copiestTask.category.save();
    }
  }

  void addOriginalTask(TaskEntity original, TaskEntity copiestTask) {
    copiestTask.originalTask.value = original;
    copiestTask.originalTask.save();
  }

  DateTime copyTimeToNewDate(DateTime toDate, DateTime fromTime) {
    return toDate.copyWith(hour: fromTime.hour, minute: fromTime.minute);
  }
}

// class CreateTaskData {
//   bool isWeekday;
//   bool hasRepeats;
//   bool? isTimes;
//   List<DateTime?> times;
// }
