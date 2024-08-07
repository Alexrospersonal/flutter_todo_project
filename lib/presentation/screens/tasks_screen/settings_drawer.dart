import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/settings_widget.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              width: 400,
              child: DrawerHeader(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
                ),
                child: const Text(
                  'Programm name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SettingsWidget()
          ],
        ),
      );
  }
}