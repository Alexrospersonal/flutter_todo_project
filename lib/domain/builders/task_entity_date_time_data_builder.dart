import 'package:flutter_todo_project/domain/builders/entity_builder.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class RepeatedTaskBuilder implements EntityBuilder<RepeatedTaskEntity> {
  final TaskDependencies dependencies;
  RepeatedTaskEntity? _entityDatesDate;

  RepeatedTaskBuilder({required this.dependencies});

  RepeatedTaskBuilder createTaskEntityDateTimeData() {
    _entityDatesDate = RepeatedTaskEntity();
    return this;
  }

  RepeatedTaskBuilder setRepeadeylyDuringWeek() {
    List<int> days = [];
    var boolWeekdays = dependencies.repeatlyNotifier.repeatOfDays;

    for (var i = 0; i < boolWeekdays.length; i++) {
      if (boolWeekdays[i] == true) {
        days.add(i+1);
      }
    }

    _entityDatesDate?.repeatDuringWeek = days;
    return this;
  }

  RepeatedTaskBuilder setEndDateOfRepeadetly() {
    _entityDatesDate?.endDateOfRepeatedly = dependencies.lastDayOfRepeatNotifier.lastDate;
    return this;
  }

  RepeatedTaskBuilder setRepeadeylyDuringDay() {
    _entityDatesDate?.repeatDuringDay = dependencies.repeatInTimeNotifier.times;
    return this;
  }

  @override
  RepeatedTaskEntity build() {
    if (_entityDatesDate == null) {
      throw Exception("Entity is null");
    }

    return _entityDatesDate!;
  }
}
