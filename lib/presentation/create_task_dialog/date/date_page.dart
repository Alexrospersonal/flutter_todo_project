import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/cards/calendar_card.dart';
import 'package:intl/intl.dart';

class TaskDateSelectorPage extends StatefulWidget {
  const TaskDateSelectorPage({super.key});

  @override
  State<TaskDateSelectorPage> createState() => _TaskDateSelectorPageState();
}

class _TaskDateSelectorPageState extends State<TaskDateSelectorPage> {
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
