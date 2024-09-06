import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/finished_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/overdue_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/repeated_task_entity.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DbService {
  static late Isar _db;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open(
        directory: dir.path,
        [
          TaskEntitySchema,
          CategoryEntitySchema,
          RepeatedTaskEntitySchema,
          FinishedTaskEntitySchema,
          OverdueTaskEntitySchema
        ],
        inspector: true);
  }

  static Isar get db => _db;
}
