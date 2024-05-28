import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_controller.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_model.dart';
import 'package:flutter_todo_project/services/category.dart';
import 'package:flutter_todo_project/services/category_manager.dart';
import 'package:provider/provider.dart';

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({super.key});

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ValueNotifier<bool> _isPriority = ValueNotifier<bool>(false);

  Category? _selectedCategory;

  void selectCategory(Category? category) {
    _selectedCategory = category;
  }

  void addNewTask(BuildContext context) {
    final model = Provider.of<HomepageModel>(context, listen: false);

    model.addTask(
        name: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TaskNameField(titleController: _titleController),
        const SizedBox(height: 20),
        TaskDescriptionField(descriptionController: _descriptionController),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TaskCategoryField(selectCategory: selectCategory),
          const Text("Пріорітетно:"),
          PriorityToggleWidget(isPriority: _isPriority),
        ]),
        const SizedBox(height: 10),
        const DateWidget(),
        const SizedBox(height: 10),
        TaskButtons(addNewTask: addNewTask)
      ],
    );
  }
}

/// Toggle priority flag in dialog window.
class PriorityToggleWidget extends StatelessWidget {
  const PriorityToggleWidget({
    super.key,
    required ValueNotifier<bool> isPriority,
  }) : _isPriority = isPriority;

  final ValueNotifier<bool> _isPriority;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPriority,
      builder: (context, value, child) {
        return IconButton(
          icon: const Icon(Icons.flag),
          iconSize: 40,
          color: _isPriority.value ? Colors.red : Colors.grey,
          onPressed: () {
            _isPriority.value = !_isPriority.value;
          },
        );
      },
    );
  }
}

class TaskButtons extends StatelessWidget {
  final void Function(BuildContext) addNewTask;

  const TaskButtons({super.key, required this.addNewTask});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            addNewTask(context);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 45)),
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(fixedSize: const Size(100, 45)),
            child: const Icon(Icons.cancel)),
      ],
    );
  }
}

class TaskCategoryField extends StatefulWidget {
  final void Function(Category?) selectCategory;

  const TaskCategoryField({super.key, required this.selectCategory});

  @override
  State<TaskCategoryField> createState() => _TaskCategoryFieldState();
}

class _TaskCategoryFieldState extends State<TaskCategoryField> {
  Category selectedCategory = CategoryManager.instance.getItem(0);
  final _newCategoryTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = CategoryManager.instance.getItems();

    // TODO: переписати сатегорії на стан вибір категорій
    void addNewCategory() {
      setState(() {
        var newCategory =
            CategoryManager.instance.addItem(_newCategoryTextField.text);
        selectedCategory = newCategory;
      });
    }

    return Row(children: [
      DropdownButton(
          hint: const Text("Choose category"),
          value: selectedCategory,
          items: categoryList.map<DropdownMenuItem<Category>>((cat) {
            return DropdownMenuItem(value: cat, child: Text(cat.name));
          }).toList(),
          onChanged: (category) {
            setState(() {
              Category cat = category ?? CategoryManager.instance.getItem(0);

              widget.selectCategory(cat);
              selectedCategory = cat;
            });
          }),
      IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text("Add new category"),
                  children: [
                    TextField(
                      controller: _newCategoryTextField,
                      decoration:
                          const InputDecoration(hintText: 'Назва завдання'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addNewCategory();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add"))
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.add))
    ]);
  }
}

class TaskDescriptionField extends StatefulWidget {
  const TaskDescriptionField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  State<TaskDescriptionField> createState() => _TaskDescriptionFieldState();
}

class _TaskDescriptionFieldState extends State<TaskDescriptionField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    widget._descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._descriptionController,
      focusNode: _focusNode,
      maxLines: _isFocused ? 5 : 1,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: const InputDecoration(
          hintText: 'Опишіть завдання', border: OutlineInputBorder()),
    );
  }
}

class TaskNameField extends StatelessWidget {
  const TaskNameField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      decoration: const InputDecoration(hintText: 'Назва завдання'),
      autofocus: true,
    );
  }
}
