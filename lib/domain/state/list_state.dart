import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/db_service.dart';
import 'package:flutter_todo_project/domain/entities/category.dart';
import 'package:flutter_todo_project/settings.dart';
import 'package:isar/isar.dart';

class ListCategoryFromDbNotifier extends AsyncNotifier<List<CategoryEntity>> {
  Future<void> loadCategories() async {
    state =
        AsyncValue.data(await DbService.db.categoryEntitys.where().findAll());
  }

  Future<void> addCategory(CategoryEntity category) async {
    await DbService.db.writeTxn(() async {
      await DbService.db.categoryEntitys.put(category);
    });
    await loadCategories();
  }

  Future<void> removeCategory(CategoryEntity category) async {
    await DbService.db.writeTxn(() async {
      await DbService.db.categoryEntitys.delete(category.id);
    });
    await loadCategories();
  }

  @override
  FutureOr<List<CategoryEntity>> build() async {
    return await DbService.db.categoryEntitys.where().findAll();
  }
}

final categoriesProvider =
    AsyncNotifierProvider<ListCategoryFromDbNotifier, List<CategoryEntity>>(
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
