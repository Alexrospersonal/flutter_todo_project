import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/date_selector_page/date_selector_page.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_dialog_main_page.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/page_view_container.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_selector_page.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_form_title.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_page_navigation.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/time_selector_page/time_selector_page.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
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
  bool isExpandedNotes = false;

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

  void updateExpandStatusForNotes(bool status) {
    setState(() {
      isExpandedNotes = status;
    });
  }

  double buildSmallerTakHeight() {
    if (isExpandedNotes) {
      return 340;
    }

    return 290;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(initialTaskDialogExpandedProvider);

    double height = isExpanded ? 590 : buildSmallerTakHeight();

    List<Widget> pages = [
      TaskDialogMainPage(
        formKey: _formKey,
        titleController: _titleController,
        descriptionController: _descriptionController,
        onItemTapped: _onItemTapped,
        callback: updateExpandStatusForNotes,
      ),
      const TaskDateSelectorPage(),
      const TimeSelectorPage(),
      const RepeatSelectorPage(),
      const Placeholder(),
      const Placeholder()
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: height,
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
              onItemTapped: _onItemTapped,
              titleController: _titleController,
              descriptionController: _descriptionController,
              callback: updateExpandStatusForNotes,
            ),
          if (isExpanded)
            TaskPageNavigation(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          Positioned(
            left: 110,
            right: 110,
            bottom: -8,
            child: DoneButton(
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
            ),
          )
        ],
      ),
    );
  }
}
