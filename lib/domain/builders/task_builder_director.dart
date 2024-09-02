import 'package:flutter_todo_project/domain/builders/task_builder.dart';
import 'package:flutter_todo_project/domain/builders/task_entity_date_time_data_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';

class TaskBuilderDirector {
  TaskBuilder? _builder;

  void setBuilder(TaskBuilder builder) {
    _builder = builder;
  }

  void validateBuilder() {
    if (_builder == null) {
      throw Exception("Set builder");
    }
  }

  TaskEntity build() {
    validateBuilder();

    var dependencies = _builder!.dependencies;
    return _builder!
        .createTaskEntity(dependencies.taskNotifier.title)
        .setNotate()
        .setCategory()
        .setColor()
        .setImportant()
        .build();
  }

  TaskEntity buildWithDate() {
    validateBuilder();

    var taskEntity = build();
    var dependencies = _builder!.dependencies;

    var taskDate = TaskEntityDateTimeDataBuilder(dependencies: dependencies)
        .createTaskEntityDateTimeData()
        .setDate()
        .setTime()
        .setRepeadeylyDuringWeek()
        .setEndDateOfRepeadetly()
        .setRepeadeylyDuringDay()
        .build();

    taskEntity.dateTimeData = taskDate;

    return taskEntity;
  }
}
