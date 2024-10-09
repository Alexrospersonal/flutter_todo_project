import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/presentation/bottom_navigation_menu/action_bottom_btn.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_page.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/settings_drawer.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/task_app_bar.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/tasks_screen.dart';
import 'package:flutter_todo_project/presentation/bottom_navigation_menu/bottom_navigation_menu.dart';

class HomePage extends ConsumerStatefulWidget {
  final int initialIndex;

  const HomePage({super.key, this.initialIndex = 0});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late int _selectedIndex;
  late final PageController _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // ref.read(initialIndexProvider.notifier).state = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    // _selectedIndex = ref.read(initialIndexProvider);
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    // final initialIndex = ref.watch(initialIndexProvider);
    // if (initialIndex != _selectedIndex) {
    //   _onItemTapped(initialIndex);
    // }

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
      bottomNavigationBar: BottomNavigateMenu(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      floatingActionButton: const CreateTaskBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
