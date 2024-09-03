import 'package:flutter/material.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/builders/task_builder.dart';
import 'package:flutter_todo_project/domain/builders/task_builder_director.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class CreateTaskController {
  final BuildContext context;

  CreateTaskController({required this.context});

  TaskBuilderDirector getTaskDirector(TaskDependencies dependencies) {
    var taskBuilder = TaskBuilder(dependencies: dependencies);
    return TaskBuilderDirector()..setBuilder(taskBuilder);
  }

  TaskEntity createTask(bool isDate, TaskBuilderDirector director) {
    if (isDate) {
      return director.buildWithDate();
    } else {
      return director.build();
    }
  }

  void saveTask() {
    TaskDependencies dependencies = TaskDependencies.fromContext(context);
    var controller = CreateTaskController(context: context);
    var director = controller.getTaskDirector(dependencies);
    var task = controller.createTask(dependencies.taskDateNotifier.isEnabled, director);

    DbService.db.writeTxn(() async {
      await DbService.db.taskEntitys.put(task);
      await task.category.save();
    });
  }
}
