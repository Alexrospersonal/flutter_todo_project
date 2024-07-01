import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class DbService {
  static late Isar _db;

  static void initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open(
      directory: dir.path,
      [TaskSchema],
      inspector: true
    );
  }

  static Isar get db => _db;
}


