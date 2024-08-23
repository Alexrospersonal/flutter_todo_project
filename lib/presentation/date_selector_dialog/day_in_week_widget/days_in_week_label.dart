import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class DayInWeekLableWidget extends StatelessWidget {
  final String dayName;
  final int index;
  final bool selectedDay;
  final void Function(int) callback;

  const DayInWeekLableWidget(
      {super.key,
      required this.dayName,
      required this.index,
      required this.selectedDay,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    Color textColor = selectedDay ? Theme.of(context).canvasColor : greyColor;

    Color labelColor = selectedDay
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    return Flexible(
      flex: 3,
      child: GestureDetector(
        onTap: () {
          callback(index);
        },
        child: Container(
          // constraints: const BoxConstraints(minWidth: 10, maxWidth: 20),
          height: 60,
          // margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mediumBorderRadius),
              color: labelColor),
          child: Center(
            child: Text(
              dayName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}