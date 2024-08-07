import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/home_page_index_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/bottom_navigation_menu/action_bottom_btn.dart';
import 'package:flutter_todo_project/presentation/screens/bottom_navigation_menu/bottom_navigation_menu.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_page.dart';
import 'package:flutter_todo_project/presentation/screens/homepage.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_container.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/settings_drawer.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/task_app_bar.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskDetails extends ConsumerStatefulWidget {
  final TaskListItemData data;

  const TaskDetails({super.key, required this.data});

  @override
  ConsumerState<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends ConsumerState<TaskDetails> {
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            initialIndex: 1,
          ),
        ),
      );
      // ref.read(initialIndexProvider.notifier).state = 1;
      // Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String startIn = S.of(context).startIn;

    return Scaffold(
      appBar: const TaskAppBar(),
      drawer: const SettingsDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data.name,
                      style: Theme.of(context).textTheme.titleLarge),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      "$startIn: ${widget.data.getFormatedStartIn(widget.data.startIn, S.of(context))}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Text("Some description text"),
                  Container(
                    height: 120,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Row(
                      children: [
                        TaskListItemDatesInfo(
                          data: widget.data,
                          textStyle: Theme.of(context).textTheme.labelMedium!,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (widget.data.important)
            Container(
              margin: const EdgeInsets.all(10),
              height: 27,
              width: 27,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  border: Border.all(color: greyColor, width: 1),
                  shape: BoxShape.circle,
                  color: Theme.of(context).canvasColor),
              alignment: Alignment.center,
              child: const Icon(
                Icons.star_rounded,
                color: starColor,
                size: 17,
              ),
            ),
        ],
      ),
      bottomNavigationBar:
          BottomNavigateMenu(selectedIndex: 0, onItemTapped: _onItemTapped),
      floatingActionButton: const CreateTaskBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
