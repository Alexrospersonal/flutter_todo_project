import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/settings.dart';

final selectedCategoryIndex = StateProvider<int>((ref) => 0);

class ListCategoriesNotifier extends Notifier<List<Category>> {
  final List<Category> baseList = List.generate(
    namesOfCaterories.length, (index) => Category(id: index, name: namesOfCaterories[index])
  );

  @override
  List<Category> build() {
    return baseList;
  }

  Category addCategory(String name) {
    Category newCategory = Category(id: state.length, name: name);
    state = [...state, newCategory];
    return newCategory;
  }

  void removeCategory() {
  }

  Category getCategoryById(int id) {
    ref.read(selectedCategoryIndex.notifier).state = id;
    return state[id];
  }

  List<Category> getCategories() {
    return state;
  }
}

final listCategoryNotifierProvider = NotifierProvider<ListCategoriesNotifier, List<Category>>(() {
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

final selectedCategoryNotifierProvider = NotifierProvider<SelectedCategoryNotifier, Category>(() {
  return SelectedCategoryNotifier();
});