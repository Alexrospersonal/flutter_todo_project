import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/add_file_to_task.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_task_settings.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_selector_widget.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_dialog_display_switch.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/color_picker_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/priority_button_widget.dart';
import 'package:flutter_todo_project/presentation/styles/task_form_style.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskForm extends ConsumerStatefulWidget {
  const TaskForm({super.key});

  @override
  ConsumerState<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _selectedIndex = 0;
  bool isError = false;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void expandForError() {
    setState(() {
      isError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(initialTaskDialogExpandedProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: isError ? (isExpanded ? 560 : 280) + 20 : isExpanded ? 560 : 280,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
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
                          child: TaskFormTitleWidget(
                              title: S.of(context).createTask),
                        ),
                        const Divider(color: greyColor),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TaskNameField(
                                      titleController: _titleController,
                                      callback: expandForError,
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
              Placeholder(),
              Placeholder()
            ],
          ),
        ),
        if (isExpanded)
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TaskDialogDisplaySwitch(
                  index: 0,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalInfoLabel,
                  iconData: Icons.menu,
                ),
                TaskDialogDisplaySwitch(
                  index: 1,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalDateLabel,
                  iconData: Icons.calendar_month,
                ),
                TaskDialogDisplaySwitch(
                  index: 2,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalTimeLabel,
                  iconData: Icons.schedule_rounded,
                ),
                TaskDialogDisplaySwitch(
                  index: 3,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalDurationLabel,
                  iconData: Icons.timer,
                ),
                TaskDialogDisplaySwitch(
                  index: 4,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalNotificationLabel,
                  iconData: Icons.notifications,
                ),
                TaskDialogDisplaySwitch(
                  index: 5,
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  buttonName: S.of(context).additionalRepeatLabel,
                  iconData: Icons.repeat,
                ),
              ],
            ),
          ),
        Positioned(
            left: 155 - 30,
            right: 155 - 30,
            bottom: -8,
            child: DoneButton(
              action: () {
                ref.read(initialTaskDialogExpandedProvider.notifier).state = false;
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

class TaskFormTitleWidget extends ConsumerWidget {
  final String title;

  const TaskFormTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          InkWell(
            onTap: () {
              ref.read(initialTaskDialogExpandedProvider.notifier).state = false;
              Navigator.of(context).pop();
            },
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
  final void Function() callback;
  final TextEditingController titleController;
  final String invalidValidationText;

  const TaskNameField(
      {super.key,
      required this.titleController,
      required this.invalidValidationText,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          callback();
          return invalidValidationText;
        }
        return null;
      },
      controller: titleController,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).canvasColor
,        contentPadding: const EdgeInsets.all(10),
        hintText: S.of(context).addTaskName,
        hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400),
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
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(smallBorderRadius),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.error, width: 2.0),
        ),
        errorStyle: TextStyle(
          fontSize: 12,
          height: 1
        )
        // errorStyle: const TextStyle(fontSize: 0)
      ),
      autofocus: false,
    );
  }
}
