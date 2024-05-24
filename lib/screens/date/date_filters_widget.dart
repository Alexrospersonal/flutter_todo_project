import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/filters/next_day_filter_widget.dart';

class FilterWrapper extends StatelessWidget {
  const FilterWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 1,
      runSpacing: 1,
      children: [NextDayFilter()],
    );
  }
}
