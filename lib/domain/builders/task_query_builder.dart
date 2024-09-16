import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';
import 'package:isar/isar.dart';

class TaskQueryBuilder {
  // Query<TaskEntity> taskQuery = DbService.db.taskEntitys.filter().isFinishedEqualTo(false);
  // Query<TaskEntity> taskQuery = DbService.db.taskEntitys.filter().isFinishedEqualTo(false);
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> query;
  TaskQueryBuilder()
      : query = DbService.db.taskEntitys.filter().isFinishedEqualTo(false).hasRepeatsEqualTo(false);

  TaskQueryBuilder addCategory(int categoryId) {
    query = query.category((q) => q.idEqualTo(categoryId));
    // додати до taskQuery category((q) => q.idEqualTo(categoryId)).build()
    return this;
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> addFilter(TaskFilter filter) {
    late QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortedQuery;
    switch (filter) {
      case TaskFilter.newest:
        sortedQuery = getNewestDate();
        break;
      case TaskFilter.oldest:
        sortedQuery = getOldestDate();
        break;
      // TODO: Handle this case.
      case TaskFilter.isComing:
      // TODO: Handle this case.
      case TaskFilter.important:
      // TODO: Handle this case.
      case TaskFilter.finished:
      // TODO: Handle this case.
      case TaskFilter.outdated:
      // TODO: Handle this case.
    }
    return sortedQuery;
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> getNewestDate() {
    return query.taskDateIsNotNull().sortByTaskDateDesc();
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> getOldestDate() {
    return query.taskDateIsNotNull().sortByTaskDate();
  }

  Query<TaskEntity> buildWithFilter(int categoryId, TaskFilter filter) {
    // addCategory(categoryId);
    var queryWithFilter = addFilter(filter);
    return queryWithFilter.build();
  }

  Query<TaskEntity> build(int categoryId) {
    // addCategory(categoryId);
    return query.build();
  }
}
