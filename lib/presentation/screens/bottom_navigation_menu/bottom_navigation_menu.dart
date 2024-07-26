import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/icons_font.dart';

class BottomNavigateMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigateMenu(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 56,
        // shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                onItemTapped(0);
              },             
              icon: const Icon(IconsFont.homeIcon, size: 21),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                onItemTapped(1);
              },
              icon: const Icon(IconsFont.calendarIcon, size: 21),
            ),
          ],
        ));
  }
}
