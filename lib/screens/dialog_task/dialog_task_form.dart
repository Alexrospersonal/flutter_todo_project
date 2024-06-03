import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/screens/calendar_page/calendar_page.dart';
import 'package:flutter_todo_project/screens/category/add_cateory_widget.dart';
import 'package:flutter_todo_project/screens/date/date_controller.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
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

    model.addTask(name: _titleController.text, description: _descriptionController.text, category: _selectedCategory);
  }

  void changeDate(DateTime date) {
    Provider.of<DateModel>(context, listen: false).changeDate(date);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       TaskNameField(titleController: _titleController),
  //       const SizedBox(height: 20),
  //       TaskDescriptionField(descriptionController: _descriptionController),
  //       // Row with category selector and priority toggle button
  //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //         TaskCategoryField(selectCategory: selectCategory),
  //         const Text("Пріорітетно:"),
  //         PriorityToggleWidget(isPriority: _isPriority),
  //       ]),
  //       const SizedBox(height: 10),
  //       CalendarWidget(changeDate: changeDate),
  //       // const DateWidget(),
  //       const SizedBox(height: 10),
  //       TaskButtons(addNewTask: addNewTask)
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const TaskFormTitleWidget(),
        const SizedBox(height: 30),
        TaskNameField(titleController: _titleController),
        const SizedBox(height: 20),
        TaskDescriptionField(descriptionController: _descriptionController),
        const SizedBox(height: 20),
        TaskCategoryField(selectCategory: selectCategory),
        const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [DateSelectorButton(), SizedBox(width: 10), ColorPicker()])
      ],
    );
  }
}

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker>{
  final _overlayController = OverlayPortalController();
  final FocusNode _overlayFocusNode = FocusNode();

  late RenderBox iconContainerRenderBox;

  Color activeColor = Colors.lime;

  List<Color> icons = [
    Colors.deepPurple,
    const Color.fromARGB(255, 199, 228, 35),
    const Color.fromARGB(255, 230, 201, 40),
    const Color.fromARGB(255, 40, 186, 230)
  ];

  void changeActiveColor(int idx) {
    setState(() {
      activeColor = icons[idx];
      _overlayController.hide();
    });
  }

  void _onOverlayFocusChange() {
    if (!_overlayFocusNode.hasFocus) {
      _overlayController.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    _overlayFocusNode.addListener(_onOverlayFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _overlayFocusNode.removeListener(_onOverlayFocusChange);
    _overlayFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _overlayController.toggle();
        _overlayFocusNode.requestFocus();
      },
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
              top: 400,
              right: 35,
              child: Container(
                  alignment: const Alignment(0, 0),
                  width: 45,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.white.withOpacity(0.7)),
                  child: IntrinsicHeight(
                    child: Column(
                        children: List.generate(
                            icons.length,
                            (index) => ListTile(
                                  focusNode: _overlayFocusNode,
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  title: Icon(Icons.circle, color: icons[index]),
                                  onTap: () {
                                    changeActiveColor(index);
                                  },
                                ))),
                  )));
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Icon(Icons.circle, color: activeColor),
        ),
      ),
    );
  }
}

class DateSelectorButton extends StatefulWidget {
  const DateSelectorButton({super.key});

  @override
  State<DateSelectorButton> createState() => _DateSelectorButtonState();
}

class _DateSelectorButtonState extends State<DateSelectorButton> {
  final String _datetext = "Щовівторка";
  final String _timetext = "18:00";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 10)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 5),
          Text(
            _datetext,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.timelapse),
          const SizedBox(width: 5),
          Text(
            _timetext,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w400
            ),
          ),
        ]));
  }
}

class TaskFormTitleWidget extends StatelessWidget {
  const TaskFormTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        "Створити завдання".toUpperCase(),
        style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w500, fontFamily: 'Montserrat'),
      ),
      InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 20.0,
          height: 26.0,
          alignment: Alignment.centerRight,
          child: const Icon(Icons.close, size: 28.0),
        ),
      ),
    ]);
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

    void addNewCategory() {
      setState(() {
        var newCategory = CategoryManager.instance.addItem(_newCategoryTextField.text);
        selectedCategory = newCategory;
      });
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        height: 35,
        padding: const EdgeInsets.fromLTRB(10, 1.5, 10, 1.5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(33),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              dropdownColor: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
              hint: const Text("Choose category"),
              style: const TextStyle(color: Colors.black, fontSize: 13.0, fontFamily: 'Montserrat', overflow: TextOverflow.ellipsis),
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
        ),
      ),

      // Invoke a new category dialog window.
      ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddCategoryDialogWidget(newCategoryTextField: _newCategoryTextField, addNewCategory: addNewCategory);
              },
            );
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(0, 0)),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 10)),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
            elevation: MaterialStateProperty.all(0),
          ),
          child: const Row(children: [
            Icon(Icons.add),
            Text(
              "Новий список",
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'Montserrat',
                // fontWeight: FontWeight.w400
              ),
            )
          ])),

      // IconButton(
      //     onPressed: () {

      //     },
      //     icon: const Icon(Icons.add))
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
      style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'),
      controller: widget._descriptionController,
      focusNode: _focusNode,
      maxLines: _isFocused ? 5 : 1,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
          hintText: 'Нотатки',
          hintStyle: const TextStyle(color: Colors.grey),
          isDense: true,
          contentPadding: const EdgeInsets.only(bottom: 7, top: 7, left: 10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(118, 253, 172, 1), width: 2.0),
          ),
          filled: true,
          fillColor: Colors.white30),
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
      style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'),
      decoration: const InputDecoration(
        hintText: 'Назва',
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(118, 253, 172, 1), width: 2.0),
        ),
      ),
      autofocus: false,
    );
  }
}
