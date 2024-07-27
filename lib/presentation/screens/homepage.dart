import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/settings_widget.dart';
import 'package:flutter_todo_project/presentation/screens/bottom_navigation_menu/action_bottom_btn.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_page.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/settings_drawer.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/task_app_bar.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/tasks.dart';
import 'package:flutter_todo_project/presentation/screens/bottom_navigation_menu/bottom_navigation_menu.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppBar(),
      drawer: const SettingsDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [TasksScreen(), CalendarScreen()],
        ),
      ),
      bottomNavigationBar: BottomNavigateMenu(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      floatingActionButton: const CreateTaskBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
