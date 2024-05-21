import 'package:flutter/material.dart';

class BottomNavigateMenu extends StatelessWidget {
  const BottomNavigateMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                // Обробник події для першої кнопки
              },
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                // Обробник події для першої кнопки
              },
              icon: const Icon(Icons.home),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                // Обробник події для першої кнопки
              },
              icon: const Icon(Icons.calendar_month),
            ),
            IconButton(
              onPressed: () {
                // Обробник події для першої кнопки
              },
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ));
  }
}
