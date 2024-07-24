
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class NestedAmPmToggle extends StatelessWidget {
  final void Function(int) callback;
  final int flex;
  final int initialValue;

  const NestedAmPmToggle({
    super.key,
    required this.flex,
    required this.initialValue,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [false, false];
    isSelected[initialValue] = true;

    return Flexible(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        width: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          color: inputBackgroundColor,
        ),
        child: ToggleButtons(
          direction: Axis.vertical,
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          isSelected: isSelected,
          onPressed: (index) {
            callback(index);
          },
          children: const [
          SizedBox(
            width: 43,
            height: 40,
            child: Center(
              child: Text(
                "AM",
                )
            ),
          ),
          SizedBox(
            width: 43,
            height: 40,
            child: Center(
              child: Text(
                "PM",
              )
            ),
          ),
        ],
        ),
      )
    );
  }
}
