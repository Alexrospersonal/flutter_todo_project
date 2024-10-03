import 'package:flutter_todo_project/domain/builders/task_query_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';
import 'package:isar/isar.dart';

class FilteredTaskQueryDirector {
  TaskQueryBuilder builder;

  FilteredTaskQueryDirector({required this.builder});

  Query<TaskEntity> buildNewest() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
        .addNotOutdated()
        .addFilter(TaskFilter.newest)
        .build();
  }

  Query<TaskEntity> buildOldest() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
        .addNotOutdated()
        .addFilter(TaskFilter.oldest)
        .build();
  }

  Query<TaskEntity> buildIsComing() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
        .addNotOutdated()
        .addFilter(TaskFilter.isComing)
        .build();
  }

  Query<TaskEntity> buildImportant() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addNotOutdated()
        .addFilter(TaskFilter.important)
        .build();
  }

  Query<TaskEntity> buildIsFinished() {
    return builder.addCategory().addFilter(TaskFilter.finished).build();
  }

  Query<TaskEntity> buildIsOutdated() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
        .addFilter(TaskFilter.outdated)
        .build();
  }

  Query<TaskEntity> buildIsToday() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
        .addNotOutdated()
        .addFilter(TaskFilter.today)
        .build();
  }

  Query<TaskEntity> buildsAll() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addAllTaskDate()
        .addNotOutdated()
        .addFilter(TaskFilter.oldest)
        .build();
  }

  Query<TaskEntity> build(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return buildsAll();
      case TaskFilter.newest:
        return buildNewest();
      case TaskFilter.oldest:
        return buildOldest();
      case TaskFilter.isComing:
        return buildIsComing();
      case TaskFilter.important:
        return buildImportant();
      case TaskFilter.finished:
        return buildIsFinished();
      case TaskFilter.outdated:
        return buildIsOutdated();
      case TaskFilter.today:
        return buildIsToday();
    }
  }
}
