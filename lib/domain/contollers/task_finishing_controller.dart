import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/finished_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';

class TaskFinishingController {
  Future<void> finishTask(int removedTaskId, TaskEntity? task) async {
    if (task?.hasRepeats == false) {
      await completeNoRepeatedTask(task);
    } else if (task?.hasRepeats == true) {
      await completeRepeatedTask(task);
    }
  }

  Future<void> completeNoRepeatedTask(TaskEntity? task) async {
    task?.isFinished = true;
    await DbService.db.taskEntitys.put(task!);
  }

  Future<void> completeRepeatedTask(TaskEntity? task) async {
    var repeatedTask = await getRepeatedTask(task);
    if (validateEndDate(repeatedTask)) {
      await setIsFinishedToTrue(repeatedTask);
    }
  }

  Future<void> removeTask(int id) async {
    await DbService.db.writeTxn(() async {
      await DbService.db.taskEntitys.delete(id);
    });
  }

  Future<RepeatedTaskEntity> getRepeatedTask(TaskEntity? task) async {
    await task?.repeatedTask.load();
    final repeatedTask = task?.repeatedTask.first;
    if (repeatedTask != null) {
      return repeatedTask;
    } else {
      throw Exception("Repeated task not exist");
    }
  }

  Future<void> addTaskToFinishedTasks(TaskEntity task) async {
    var finishedTask = FinishedTaskEntity(finishedDate: DateTime.now());
    finishedTask.task.value = task;

    await DbService.db.finishedTaskEntitys.put(finishedTask);
    finishedTask.task.save();
  }

  bool validateEndDate(RepeatedTaskEntity? repeatedTask) {
    return repeatedTask != null && repeatedTask.endDateOfRepeatedly != null;
  }

  Future<void> setIsFinishedToTrue(RepeatedTaskEntity repeatedTask) async {
    if (isDeterminatedDate(repeatedTask.endDateOfRepeatedly!)) {
      repeatedTask.isFinished = true;
      await saveCompletedTask(repeatedTask);
    }
  }

  bool isDeterminatedDate(taskDate) {
    var date = DateTime.now();
    return taskDate.isBefore(date);
  }

  Future<void> saveCompletedTask(RepeatedTaskEntity repeatedTask) async {
    await DbService.db.repeatedTaskEntitys.put(repeatedTask);
  }
}