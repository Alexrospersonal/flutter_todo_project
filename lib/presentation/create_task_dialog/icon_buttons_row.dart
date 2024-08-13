import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/color_picker_widget.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/priority_button_widget.dart';

class IconButtonsRow extends StatelessWidget {
  const IconButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          PriorityButton(),
          ColorPicker(),
          //AddFileToTaskButton()
        ],
      ),
    );
  }
}
