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
      : query = DbService.db.taskEntitys
            .filter()
            // .isFinishedEqualTo(false)
            .group((q) => q
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
    DateTime startOfDay =
        DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
    DateTime endOfDay = DateTime.now()
        .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);

    query = query.group((q) => q
        .taskDateIsNull()
        .or()
        .taskDateGreaterThan(DateTime.now())
        .or()
        .group((q) => q
            .hasTimeEqualTo(false)
            .and()
            .taskDateBetween(startOfDay, endOfDay)));
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
    // DateTime endOfDay = DateTime.now()
    //     .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);

    DateTime startOfDay =
        DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

    // .group(
    //     (q) => q.hasTimeEqualTo(false).and().taskDateGreaterThan(endOfDay))

    return query
        .group((q) =>
            query.hasTimeEqualTo(false).and().taskDateLessThan(startOfDay))
        .or()
        .group((q) =>
            query.hasTimeEqualTo(true).and().taskDateLessThan(DateTime.now()));

    // return query.hasTimeEqualTo(false).and().taskDateLessThan(startOfDay);

    // return query.hasTimeEqualTo(true).and().taskDateLessThan(DateTime.now());

    // return query.taskDateLessThan(DateTime.now());
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
