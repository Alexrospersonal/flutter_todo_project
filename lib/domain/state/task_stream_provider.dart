import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:isar/isar.dart';

final taskStreamProvier = StreamProvider<List<TaskEntity>>((ref) {
  // TODO: тут логіка отрмання, можна винести в окремий клас.
  //Залежна від інших станів таких як категорія та фільтер.
  //Тобто при зміні їх і оновлюється цей стан. МОжливо придумати кешування даних.
  // Отривувані дані формувати в TaskListItemData

  // Отримати звичайні завдання

  // TODO: додпти код з документа, виправити цю всю жалість
  return DbService.db.taskEntitys
      .filter()
      // .category((q) => q.idEqualTo(categoryId))
      .isFinishedEqualTo(false)
      .watch(fireImmediately: true);
});
