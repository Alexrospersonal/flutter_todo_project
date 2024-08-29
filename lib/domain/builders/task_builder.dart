import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class TaskBuilder {
  final TaskDependencies dependencies;

  TaskBuilder({required this.dependencies});

  TaskEntity build() {
    // TODO: переписати клас використовуючу патерн білдер
    var newTask = TaskEntity(title: dependencies.taskNotifier.title);
    if (dependencies.taskNotifier.note != null) {
      newTask.notate = dependencies.taskNotifier.note;
    }
    if (dependencies.taskNotifier.category != null) {
      newTask.category.value = dependencies.taskNotifier.category;
    }
    newTask.color = dependencies.taskNotifier.color.value;
    newTask.important = dependencies.taskNotifier.important;

    return newTask;
  }
}
