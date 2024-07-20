import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class RegularButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const RegularButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: regularButtonWidth,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: regularButtonTextStyle,
        )
      ),
    );
  }
}