import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/bottom_navigation_menu/action_bottom_btn.dart';
import 'package:flutter_todo_project/screens/homepage/homepage_widget.dart';
import 'package:flutter_todo_project/screens/bottom_navigation_menu/bottom_navigation_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePageWidget(),
      bottomNavigationBar: BottomNavigateMenu(),
      floatingActionButton: ActionBottomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
