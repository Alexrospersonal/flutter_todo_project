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

  RepeatedTaskBuilderDirector getRepeatedTaskDirector(TaskDependencies dependencies) {
    var builder = RepeatedTaskBuilder(dependencies: dependencies);
    return RepeatedTaskBuilderDirector()..setBuilder(builder);
  }

  void saveTask() {
    TaskDependencies dependencies = TaskDependencies.fromContext(context);
    var director = getTaskDirector(dependencies);
    var task = director.build();

    RepeatedTaskEntity? repeatedTaskEntity;

    if (task.hasRepeats) {
      var director = getRepeatedTaskDirector(dependencies);
      repeatedTaskEntity = director.build();
      repeatedTaskEntity.task.value = task;
    }

    DbService.db.writeTxn(() async {
      await DbService.db.taskEntitys.put(task);
      await task.category.save();

      if (repeatedTaskEntity != null) {
        await DbService.db.repeatedTaskEntitys.put(repeatedTaskEntity);
        await repeatedTaskEntity.task.save();
      }
    });
  }
}
