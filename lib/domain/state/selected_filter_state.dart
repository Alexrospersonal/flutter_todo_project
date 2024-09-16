import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/task_filters.dart';

final selectedFilterIndexProvider = StateProvider<TaskFilter>((ref) => TaskFilter.newest);
