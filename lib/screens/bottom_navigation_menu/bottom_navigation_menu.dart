import 'package:flutter/material.dart';

class BottomNavigateMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigateMenu(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                onItemTapped(0);
              },
              icon: Icon(
                Icons.menu,
                color: selectedIndex == 0 ? Colors.blueAccent : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(1);
              },
              icon: Icon(
                Icons.home,
                color: selectedIndex == 1 ? Colors.blueAccent : Colors.black,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                onItemTapped(2);
              },
              icon: Icon(
                Icons.calendar_month,
                color: selectedIndex == 2 ? Colors.blueAccent : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(3);
              },
              icon: Icon(
                Icons.account_circle,
                color: selectedIndex == 3 ? Colors.blueAccent : Colors.black,
              ),
            ),
          ],
        ));
  }
}
