import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';
import 'package:isar/isar.dart';

class TaskQueryBuilder {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> query;
  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>? sortedQuery;
  final int categoryId;

  TaskQueryBuilder({required this.categoryId})
      : query = DbService.db.taskEntitys.filter().isFinishedEqualTo(false).group((q) => q
              .isCopyEqualTo(true)
              .or()
              .isCopyEqualTo(false)
              .and()
              .hasRepeatsEqualTo(false));

  TaskQueryBuilder addCategory() {
    query = query.category((q) => q.idEqualTo(categoryId));
    return this;
  }

  TaskQueryBuilder addNotOutdated() {
    query = query.group(
        (q) => q.taskDateIsNull().or().taskDateGreaterThan(DateTime.now()));
    return this;
  }

  TaskQueryBuilder addIsNotFinished() {
    query = query.isFinishedEqualTo(false);
    return this;
  }

  TaskQueryBuilder addAllTaskDate() {
    query = query.group((q) => q.taskDateIsNull().or().taskDateIsNotNull());
    return this;
  }

  TaskQueryBuilder addTaskDateIsNotNull() {
    query = query.taskDateIsNotNull();
    return this;
  }

  TaskQueryBuilder addFilter(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        query = query;
      case TaskFilter.newest:
        sortedQuery = getNewestDate();
      case TaskFilter.oldest:
        sortedQuery = getOldestDate();
      case TaskFilter.isComing:
        query = getIsComing();
      case TaskFilter.important:
        query = getImportant();
      case TaskFilter.finished:
        query = getFinished();
      case TaskFilter.outdated:
        query = getOutdated();
      case TaskFilter.today:
        query = getToday();
    }
    return this;
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> getNewestDate() {
    return query.sortByTaskDateDesc();
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> getOldestDate() {
    return query.sortByTaskDate();
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> getImportant() {
    return query.importantEqualTo(true);
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> getIsComing() {
    return query.taskDateGreaterThan(DateTime.now());
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> getFinished() {
    return query.isFinishedEqualTo(true);
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> getOutdated() {
    return query.taskDateLessThan(DateTime.now());
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> getToday() {
    var today = DateTime.now().copyWith(hour: 0, minute: 0);
    return query.taskDateBetween(today.subtract(const Duration(days: 1)),
        today.add(const Duration(days: 1)));
  }

  Query<TaskEntity> build() {
    if (sortedQuery != null) {
      return sortedQuery!.build();
    }
    return query.build();
  }
}

class TaskQueryBuilderDirector {
  TaskQueryBuilder builder;

  TaskQueryBuilderDirector({required this.builder});

  Query<TaskEntity> buildNewest() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addNotOutdated()
        .addFilter(TaskFilter.newest)
        .build();
  }

  Query<TaskEntity> buildOldest() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addNotOutdated()
        .addFilter(TaskFilter.oldest)
        .build();
  }

  Query<TaskEntity> buildIsComing() {
    return builder
        .addCategory()
        .addIsNotFinished()
        .addTaskDateIsNotNull()
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
        .addFilter(TaskFilter.today)
        .build();
  }

  Query<TaskEntity> buildsAll() {
    return builder.addCategory().addIsNotFinished().addAllTaskDate().build();
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
