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
        TaskCategoryField(selectCategory: selectCategory),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        const DateWidget(),
        // DateWidget(),
        const SizedBox(height: 10),
        TaskButtons(addNewTask: addNewTask)
      ],
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

  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = CategoryManager.instance.getItems();

    return DropdownButton(
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
        });
  }
}

class TaskDescriptionField extends StatelessWidget {
  const TaskDescriptionField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _descriptionController,
      maxLines: null,
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
