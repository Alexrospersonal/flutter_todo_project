import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/add_file_to_task.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_task_settings.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_selector_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/color_picker_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/priority_button_widget.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/date_selector_widget.dart';
import 'package:flutter_todo_project/presentation/styles/task_form_style.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool validateTaskData() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DialogTaskFormBackgroundStyle(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: TaskFormTitleWidget(title: S.of(context).createTask),
                  ),
                  const Divider(color: greyColor),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TaskNameField(
                                titleController: _titleController,
                                invalidValidationText:
                                    S.of(context).addTaskName,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const PriorityButton()
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TaskDescriptionField(
                                  descriptionController:
                                      _descriptionController),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const ColorPicker(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            CategorySelectorWidget(),
                            SizedBox(
                              width: 10,
                            ),
                            AddFileToTaskButton()
                          ],
                        ),
                        const SizedBox(height: 10),
                        const AdditionalTaskSetting(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                  // const Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       DateSelectorButton(),
                  //       SizedBox(width: 10),
                  //       SizedBox(width: 10),
                  //     ]),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            left: 155 - 30,
            right: 155 - 30,
            bottom: -8,
            child: DoneButton(
              action: () {
                // var db = DbService.db;
                // db.writeTxn(() async {
                //   Task task = Task();
                //   task.title = "Task title 1";
                //   await db.tasks.put(task);
                // });
                return validateTaskData();
              },
            ))
      ],
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
    final taskState = Provider.of<TaskState>(context, listen: false);

    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DateSelectorWidget(taskState: taskState)));
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 6, horizontal: 10)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 3),
          Text(
            _datetext,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(width: 7),
          const Icon(Icons.timelapse),
          const SizedBox(width: 3),
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
  final String title;

  const TaskFormTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const SizedBox(
              width: 12.0,
              height: 12.0,
              child: Center(child: Icon(Icons.close, size: 16.0)),
            ),
          ),
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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat'),
      controller: widget._descriptionController,
      focusNode: _focusNode,
      autofocus: false,
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
            borderSide: const BorderSide(
                color: Color.fromRGBO(118, 253, 172, 1), width: 2.0),
          ),
          filled: true,
          fillColor: Colors.white30),
    );
  }
}

class TaskNameField extends StatelessWidget {
  final TextEditingController titleController;
  final String invalidValidationText;

  const TaskNameField(
      {super.key,
      required this.titleController,
      required this.invalidValidationText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(smallBorderRadius)),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidValidationText;
          }
          return null;
        },
        controller: titleController,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: S.of(context).addTaskName,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
        ),
        autofocus: false,
      ),
    );
  }
}
