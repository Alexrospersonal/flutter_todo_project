import 'package:flutter_todo_project/domain/builders/entity_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class TaskBuilder implements EntityBuilder<TaskEntity> {
  final TaskDependencies dependencies;

  TaskBuilder({required this.dependencies});

  TaskEntity? _entity;

  TaskBuilder createTaskEntity(String title) {
    _entity = TaskEntity(title: title);
    return this;
  }

  TaskBuilder setNotate() {
    if (dependencies.taskNotifier.note != null) {
      _entity?.notate = dependencies.taskNotifier.note;
    }
    return this;
  }

  TaskBuilder setCategory() {
    if (dependencies.taskNotifier.category != null) {
      _entity?.category.value = dependencies.taskNotifier.category;
    }
    return this;
  }

  TaskBuilder setColor() {
    _entity?.color = dependencies.taskNotifier.color.value;
    return this;
  }

  TaskBuilder setImportant() {
    _entity?.important = dependencies.taskNotifier.important;
    return this;
  }

  void validateEntity() {
    if (_entity == null) {
      throw Exception("Entity is null");
    }
  }

  @override
  TaskEntity build() {
    validateEntity();
    return _entity!;
  }
}
