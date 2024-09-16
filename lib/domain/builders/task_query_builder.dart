import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';
import 'package:isar/isar.dart';

class TaskQueryBuilder {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> query;
  TaskQueryBuilder()
      : query = DbService.db.taskEntitys.filter().hasRepeatsEqualTo(false);

  TaskQueryBuilder addCategory(int categoryId) {
    query = query.category((q) => q.idEqualTo(categoryId));
    return this;
  }

  TaskQueryBuilder addDateFilter() {
    var today = DateTime.now().copyWith(hour: 0, minute: 0);
    query = query.taskDateBetween(today.subtract(const Duration(days: 1)),
        today.add(const Duration(days: 1)));
    return this;
  }

  TaskQueryBuilder addIsFinished() {
    query = query.isFinishedEqualTo(false);
    return this;
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>? addFilter(
      TaskFilter filter) {
    QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>? sortedQuery;
    switch (filter) {
      case TaskFilter.newest:
        sortedQuery = getNewestDate();
        break;
      case TaskFilter.oldest:
        sortedQuery = getOldestDate();
        break;
      case TaskFilter.isComing:
        query = getIsComing();
      case TaskFilter.important:
        query = getImportant();
      case TaskFilter.finished:
        query = getFinished();
      case TaskFilter.outdated:
        query = getOutdated();
    }
    return sortedQuery;
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
    return query.isFinishedEqualTo(false).taskDateLessThan(DateTime.now());
  }

  TaskQueryBuilder getNotOutdated() {
    var now = DateTime.now();
    query = query.taskDateGreaterThan(now);
    return this;
  }

  Query<TaskEntity> buildWithFilter(int categoryId, TaskFilter filter) {
    if (categoryId == 1) {
      addDateFilter();
    } else {
      addCategory(categoryId);
    }

    // TODO: винести завдання без дати в окремий потік

    // if (filter != TaskFilter.outdated) {
    //   getNotOutdated();
    // }

    if (filter != TaskFilter.finished) {
      addIsFinished();
    }

    var queryWithFilter = addFilter(filter);
    if (queryWithFilter != null) {
      return queryWithFilter.build();
    }
    return query.build();
  }

  Query<TaskEntity> build(int categoryId) {
    // addCategory(categoryId);
    return query.build();
  }
}
