import 'package:flutter_todo_project/data/services/category.dart';
import 'package:flutter_todo_project/data/services/manager_item.dart';

abstract class Manager<T extends ManagerItem> {
  final List<T> _list = [];

  void addItem(String name);

  T removeItem(int id);

  T getItem(int id);

  List<T> getItems();
}

// TODO: додати валідацію даних
class CategoryManager extends Manager<Category> {
  CategoryManager._privateConstructor();

  static final CategoryManager _instance =
      CategoryManager._privateConstructor();

  static CategoryManager get instance => _instance;

  @override
  Category addItem(String name) {
    Category newCategory = Category(id: _list.length, name: name);
    _list.add(newCategory);
    return newCategory;
  }

  @override
  Category removeItem(int id) {
    return _list.removeAt(id);
  }

  @override
  Category getItem(int id) {
    return _list[id];
  }

  @override
  List<Category> getItems() {
    return _list;
  }
}
