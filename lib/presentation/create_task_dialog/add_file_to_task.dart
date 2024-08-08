import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class AddFileToTaskButton extends StatelessWidget {
  const AddFileToTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).canvasColor,
          // borderRadius: BorderRadius.circular(35),
        ),
        child: const Icon(
          Icons.attach_file_rounded,
          color: greyColor,
          size: 22,
        ),
      ),
    );
  }
}
