import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

List<Color> taskColors = [
    Colors.white,
    Colors.deepPurple,
    const Color.fromARGB(255, 199, 228, 35),
    const Color.fromARGB(255, 230, 201, 40),
    const Color.fromARGB(255, 40, 186, 230)
];

final BoxDecoration outerCardStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(bigBorderRadius),
  color: backgroundCardColor
);

const TextStyle regularButtonTextStyle = TextStyle(
  fontSize: 16
);

const TextStyle titleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal
);