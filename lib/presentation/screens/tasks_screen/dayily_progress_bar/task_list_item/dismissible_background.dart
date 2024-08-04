import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class DismissedBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final AlignmentGeometry aligment;

  const DismissedBackground(
      {super.key,
      required this.color,
      required this.icon,
      required this.aligment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(smallBorderRadius), color: color),
      alignment: aligment,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
