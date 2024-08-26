import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/smiles_data.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class EmojiSwicthCategoryButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final void Function(int) callback;
  const EmojiSwicthCategoryButton(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    Color bgColor = index == selectedIndex
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    return GestureDetector(
      onTap: () => callback(index),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumBorderRadius),
            color: bgColor),
        child: Center(
          child:
              Text(emojiCategory[index], style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
