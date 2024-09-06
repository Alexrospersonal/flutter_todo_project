import 'package:flutter_todo_project/domain/builders/task_entity_date_time_data_builder.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';

class RepeatedTaskBuilderDirector {
  RepeatedTaskBuilder? _builder;

  void setBuilder(RepeatedTaskBuilder builder) {
    _builder = builder;
  }

  void validateBuilder() {
    if (_builder == null) {
      throw Exception("Set builder");
    }
  }

  RepeatedTaskEntity build() {
    validateBuilder();

    var dependencies = _builder!.dependencies;

    var taskRepeat = RepeatedTaskBuilder(dependencies: dependencies)
        .createTaskEntityDateTimeData()
        .setRepeadeylyDuringWeek()
        .setEndDateOfRepeadetly()
        .setRepeadeylyDuringDay()
        .build();

    return taskRepeat;
  }
}
