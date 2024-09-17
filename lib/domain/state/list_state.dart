import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/domain/entities/task.dart';
import 'package:flutter_todo_project/settings.dart';
import 'package:isar/isar.dart';

class CategoryData {
  final String name;
  final String emoji;
  final int tasks;
  final int categoryId;

  const CategoryData(
      {required this.name,
      required this.emoji,
      required this.tasks,
      required this.categoryId});
}

class ListCategoryFromDbNotifier extends AsyncNotifier<List<CategoryData>> {
  Future<void> loadCategories() async {
    state = AsyncValue.data(await getData());
  }

  Future<int> addCategory(CategoryEntity category) async {
    late int id;

    await DbService.db.writeTxn(() async {
      id = await DbService.db.categoryEntitys.put(category);
    });
    await loadCategories();
    return id;
  }

  Future<void> removeCategory(CategoryEntity category) async {
    await DbService.db.writeTxn(() async {
      await DbService.db.categoryEntitys.delete(category.id);
    });
    await loadCategories();
  }

  Future<CategoryData> buildCategoryData(CategoryEntity cat) async {
    int tasks = 0;

    if (cat.name == "#01") {
      var today = DateTime.now().copyWith(hour: 0, minute: 0);
      tasks = await DbService.db.taskEntitys
          .filter()
          .isFinishedEqualTo(false)
          .taskDateBetween(today.subtract(const Duration(days: 1)),
              today.add(const Duration(days: 1)))
          .group((q) =>
              q.taskDateIsNull().or().taskDateGreaterThan(DateTime.now()))
          .count();
    } else {
      cat.tasks.load();
      tasks = await cat.tasks.filter().isFinishedEqualTo(false).count();
    }
    return CategoryData(
        name: cat.name, emoji: cat.emoji, tasks: tasks, categoryId: cat.id);
  }

  Future<List<CategoryData>> getData() async {
    var categories = await DbService.db.categoryEntitys.where().findAll();
    var categoriesData =
        categories.map((cat) async => await buildCategoryData(cat));
    return Future.wait(categoriesData);
  }

  @override
  FutureOr<List<CategoryData>> build() async {
    var categories = await DbService.db.categoryEntitys.where().findAll();
    var categoriesData =
        categories.map((cat) async => await buildCategoryData(cat));
    return Future.wait(categoriesData);
  }
}

final selectedCategoryId = StateProvider<int>((ref) => 1);

final categoriesProvider =
    AsyncNotifierProvider<ListCategoryFromDbNotifier, List<CategoryData>>(
        () => ListCategoryFromDbNotifier());

final selectedCategoryIndex = StateProvider<int>((ref) => 0);

class ListCategoriesNotifier extends Notifier<List<Category>> {
  final List<Category> baseList = List.generate(namesOfCaterories.length,
      (index) => Category(id: index, name: namesOfCaterories[index]));

  @override
  List<Category> build() {
    return baseList;
  }

  Category addCategory(String name) {
    Category newCategory = Category(id: state.length, name: name);
    state = [...state, newCategory];
    return newCategory;
  }

  void removeCategory() {}

  Category getCategoryById(int id) {
    ref.read(selectedCategoryIndex.notifier).state = id;
    return state[id];
  }

  List<Category> getCategories() {
    return state;
  }
}

final listCategoryNotifierProvider =
    NotifierProvider<ListCategoriesNotifier, List<Category>>(() {
  return ListCategoriesNotifier();
});

class SelectedCategoryNotifier extends Notifier<Category> {
  @override
  Category build() {
    final list = ref.read(listCategoryNotifierProvider);
    return list.first;
  }

  void selectCategory(Category cat) {
    state = cat;
  }
}

final selectedCategoryNotifierProvider =
    NotifierProvider<SelectedCategoryNotifier, Category>(() {
  return SelectedCategoryNotifier();
});
