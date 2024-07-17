import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';

List<Color> taskColors = [
    Colors.white,
    Colors.deepPurple,
    const Color.fromARGB(255, 199, 228, 35),
    const Color.fromARGB(255, 230, 201, 40),
    const Color.fromARGB(255, 40, 186, 230)
];

const Color backgroundCardColor = Colors.white;

const double bigBorderRadius = 16.0;
const double mediumBorderRadius = 8.0;
const double smallBorderRadius = 4.0;

const double cardPadding = 15.0;

final Color cancelBtnColor = Colors.red[400]!;
final Color comfirmBtnColor = Colors.green[400]!;
const double amountOfColorDimming = 0.3;

const double regularButtonWidth = 150.0;

final BoxDecoration outerCardStyle = BoxDecoration(
  border: Border.all(
    width: 1,
    color: Colors.grey[200]!
  ),
  borderRadius: BorderRadius.circular(bigBorderRadius),
  color: backgroundCardColor
);

ButtonStyle createRegularButtonStyleWithParams(Color color) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return darkenColor(color, amount: amountOfColorDimming);
      }
      return color;
    }),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediumBorderRadius)
      )
    )
  );
}

final ButtonStyle cancelButtonStyle = createRegularButtonStyleWithParams(cancelBtnColor);
final ButtonStyle comfirmButtonStyle = createRegularButtonStyleWithParams(comfirmBtnColor);

const TextStyle regularButtonTextStyle = TextStyle(
  fontSize: 16
);

const TextStyle titleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal
);