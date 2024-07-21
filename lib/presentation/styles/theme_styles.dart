import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

const Color primaryColor = Color.fromRGBO(47, 215, 184, 1);
const Color onPrimaryColor = Colors.white;

const Color backgroundCardColor = Color.fromRGBO(238, 240, 242, 1);
const Color inputBackgroundColor = Colors.white;
const Color textColor = Color.fromRGBO(53, 53, 53, 1);
const Color greyTextColor = Color.fromRGBO(99, 99, 99, 1);

const double bigBorderRadius = 16.0;
const double mediumBorderRadius = 8.0;
const double smallBorderRadius = 4.0;

const double baseBorderWidth = 2.0;

const double cardPadding = 15.0;

final Color cancelBtnColor = Colors.red[400]!;
final Color comfirmBtnColor = Colors.green[400]!;
final Color borderColor = Colors.grey[350]!;
const double amountOfColorDimming = 0.3;

const double regularButtonWidth = 150.0;

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: Color.fromRGBO(47, 215, 184, 1),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Color.fromRGBO(53, 53, 53, 1),
    surface: Color.fromRGBO(238, 240, 242, 1),
    onSurface: Color.fromRGBO(53, 53, 53, 1)
  ),
  iconTheme:const IconThemeData(
    color: Color.fromRGBO(60, 60, 60, 1)
  ),
  // filledButtonTheme: FilledButtonThemeData(
  //   style: comfirmButtonStyle
  // ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    borderRadius: BorderRadius.circular(mediumBorderRadius),
    constraints: const BoxConstraints(
      // minWidth: 43,
      // maxWidth: 43,
      // maxHeight: 80
    ),
    selectedColor: inputBackgroundColor,
    fillColor: primaryColor,
    color: textColor,
    borderColor: Colors.transparent,
    borderWidth: 0
  ),
);

// colors



// ToggleButtons(
//           direction: Axis.vertical,
//           constraints: const BoxConstraints(
//             maxHeight: 37
//           ),
//           borderRadius: BorderRadius.circular(mediumBorderRadius),
//           // borderWidth: baseBorderWidth,
//           // borderColor: borderColor,
//           // selectedColor: Colors.white,
//           // selectedBorderColor: comfirmBtnColor,
//           // fillColor: comfirmBtnColor,
//           isSelected: isSelected,
//           onPressed: (index) {
//             setState(() {
//               for (int i = 0; i < isSelected.length; i++) {
//                 isSelected[i] = i == index;
//               }
//             });
//             widget.callback(index);
//           },
//           children: const [
//           Center(
//             child: Text(
//               "AM",
//               style: regularButtonTextStyle
//               )
//           ),
//           Center(
//             child: Text(
//               "PM",
//               style: regularButtonTextStyle,
//             )
//           ),
//         ],
//         ),