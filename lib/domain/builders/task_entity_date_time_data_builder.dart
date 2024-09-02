import 'package:flutter_todo_project/domain/builders/entity_builder.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_dependencies_notifier.dart';

class TaskEntityDateTimeDataBuilder implements EntityBuilder<TaskEntityDateTimeData> {
  final TaskDependencies dependencies;
  TaskEntityDateTimeData? _entityDatesDate;

  TaskEntityDateTimeDataBuilder({required this.dependencies});

  TaskEntityDateTimeDataBuilder createTaskEntityDateTimeData() {
    _entityDatesDate = TaskEntityDateTimeData();
    return this;
  }

  TaskEntityDateTimeDataBuilder setDate() {
    _entityDatesDate?.taskDate = dependencies.taskDateNotifier.taskDateTime;
    return this;
  }

  TaskEntityDateTimeDataBuilder setTime() {
    var hour = dependencies.taskTimeNotifier.taskDateTime?.hour;
    var minute = dependencies.taskTimeNotifier.taskDateTime?.minute;
    _entityDatesDate?.taskDate = _entityDatesDate?.taskDate?.copyWith(hour: hour, minute: minute);
    _entityDatesDate?.isTime = dependencies.taskTimeNotifier.isEnabled;
    return this;
  }

  TaskEntityDateTimeDataBuilder setRepeadeylyDuringWeek() {
    _entityDatesDate?.repeatDuringWeek = dependencies.repeatlyNotifier.repeatOfDays;
    _entityDatesDate?.isRepeatedly = dependencies.repeatlyNotifier.isEnabled;
    return this;
  }

  TaskEntityDateTimeDataBuilder setEndDateOfRepeadetly() {
    _entityDatesDate?.endDateOfRepeadetly = dependencies.lastDayOfRepeatNotifier.lastDate;
    return this;
  }

  TaskEntityDateTimeDataBuilder setRepeadeylyDuringDay() {
    _entityDatesDate?.repeatDuringDay = dependencies.repeatInTimeNotifier.times;
    return this;
  }

  @override
  TaskEntityDateTimeData build() {
    if (_entityDatesDate == null) {
      throw Exception("Entity is null");
    }

    return _entityDatesDate!;
  }
}
