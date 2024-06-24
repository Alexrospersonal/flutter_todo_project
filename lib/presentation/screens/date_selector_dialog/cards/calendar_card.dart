import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CalendarWidget()
      ],
    );
  }
}