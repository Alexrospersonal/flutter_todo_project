import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_dialog_main_page.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/page_view_container.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_form_title.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_page_navigation.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskForm extends ConsumerStatefulWidget {
  const TaskForm({super.key});

  @override
  ConsumerState<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends ConsumerState<TaskForm> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _selectedIndex = 0;
  bool isError = false;

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

  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(initialTaskDialogExpandedProvider);
    List<Widget> pages = [
      TaskDialogMainPage(
        formKey: _formKey,
        titleController: _titleController,
      ),
      Container(
        color: Colors.red,
      ),
      Placeholder(),
      Placeholder()
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: isExpanded ? 590 : 280,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              TaskFormTitleWidget(title: S.of(context).createTask),
              const Divider(color: greyColor),
            ],
          ),
          if (isExpanded)
            TaskPageViewContainer(
              pageController: _pageController,
              onPageChanged: changePage,
              children: pages,
            ),
          if (!isExpanded)
            TaskDialogMainPage(
              topPadding: 45,
              formKey: _formKey,
              titleController: _titleController,
            ),
          if (isExpanded)
            TaskPageNavigation(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          DoneButton(
            action: () {
              ref.read(initialTaskDialogExpandedProvider.notifier).state =
                  false;
              // var db = DbService.db;
              // db.writeTxn(() async {
              //   Task task = Task();
              //   task.title = "Task title 1";
              //   await db.tasks.put(task);
              // });
              return validateTaskData();
            },
          )
        ],
      ),
    );
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
