import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(47, 215, 184, 1);
const Color onPrimaryColor = Colors.white;

const Color backgroundCardColor = Color.fromRGBO(238, 240, 242, 1);
const Color inputBackgroundColor = Colors.white;
const Color textColor = Color.fromRGBO(53, 53, 53, 1);
const Color greyTextColor = Color.fromRGBO(99, 99, 99, 1);
const Color greyColor = Color.fromRGBO(191, 191, 191, 1);

const double bigBorderRadius = 16.0;
const double mediumBorderRadius = 8.0;
const double smallBorderRadius = 4.0;

const double baseBorderWidth = 2.0;

const double cardPadding = 25.0;

final Color cancelBtnColor = Colors.red[400]!;
final Color comfirmBtnColor = Colors.green[400]!;
final Color borderColor = Colors.grey[350]!;
const double amountOfColorDimming = 0.3;

const double regularButtonWidth = 150.0;

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: Color.fromRGBO(47, 215, 184, 1),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color.fromRGBO(53, 53, 53, 1)),
  textTheme: const TextTheme(
      headlineMedium: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 1.7),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
      labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(191, 191, 191, 1))),
  iconTheme: const IconThemeData(color: Color.fromRGBO(96, 96, 96, 1)),
  cardColor: const Color.fromRGBO(238, 240, 242, 1),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Fixel',
  toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(mediumBorderRadius),
      constraints: const BoxConstraints(),
      selectedColor: inputBackgroundColor,
      fillColor: primaryColor,
      color: textColor,
      borderColor: Colors.transparent,
      borderWidth: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shadowColor: WidgetStateColor.transparent,
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius))),
          textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16)))),
  appBarTheme: const AppBarTheme(
      backgroundColor: backgroundCardColor,
      foregroundColor: Color.fromRGBO(96, 96, 96, 1)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: backgroundCardColor,
    padding: EdgeInsets.all(10),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    shape: CircleBorder(),
  ),
);

final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: Color.fromRGBO(47, 215, 184, 1),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        // background: Colors.white,
        // onBackground: Color.fromRGBO(53, 53, 53, 1),
        surface: Color.fromRGBO(49, 49, 49, 1),
        onSurface: onPrimaryColor),
    iconTheme: const IconThemeData(color: Color.fromRGBO(60, 60, 60, 1)),
    cardColor: const Color.fromRGBO(70, 70, 70, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(49, 49, 49, 1),
    fontFamily: 'Fixel',
    toggleButtonsTheme: ToggleButtonsThemeData(
        borderRadius: BorderRadius.circular(mediumBorderRadius),
        constraints: const BoxConstraints(),
        selectedColor: inputBackgroundColor,
        fillColor: primaryColor,
        color: textColor,
        borderColor: Colors.transparent,
        borderWidth: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shadowColor: WidgetStateColor.transparent,
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius))),
            textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16)))));




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