import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CalendarWidget(),
          )),
          // Expanded(child: Placeholder())
        ],
      ),
    );
  }
}
