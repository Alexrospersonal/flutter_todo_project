import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/settings.dart';

final selectedFilterIndexProvider = StateProvider<Filter>((ref) => Filter.newest);