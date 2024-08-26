import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/cards/calendar_card.dart';

class DateSelectorPage extends StatelessWidget {
  const DateSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 0),
      child: Column(
        children: [CalendarCardWidget()],
      ),
    );
  }
}
