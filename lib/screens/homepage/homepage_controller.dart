import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/bottom_navigation_menu/action_bottom_btn.dart';
import 'package:flutter_todo_project/screens/calendar_page/calendar_page.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_widget.dart';
import 'package:flutter_todo_project/screens/bottom_navigation_menu/bottom_navigation_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HomePageWidget(),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg1.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [Placeholder(), HomePageWidget(), CalendarPage(), Placeholder()],
        ),
      ),
      bottomNavigationBar: BottomNavigateMenu(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      floatingActionButton: const ActionBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
