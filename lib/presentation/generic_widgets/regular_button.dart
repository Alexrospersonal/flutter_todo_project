import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

class RegularButton extends StatelessWidget {
  final void Function()? onPressed;
  final ButtonStyle style;
  final String text;

  const RegularButton({
    super.key,
    required this.text,
    required this.style,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: regularButtonWidth,
      child: FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(
          text,
          style: regularButtonTextStyle,
        )
      ),
    );
  }
}