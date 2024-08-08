import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(47, 215, 184, 1);
const Color primaryColorWithOpacity = Color.fromRGBO(69, 255, 221, 1);
const Color onPrimaryColor = Colors.white;

const Color backgroundCardColor = Color.fromRGBO(238, 240, 242, 1);
const Color inputBackgroundColor = Colors.white;
const Color textColor = Color.fromRGBO(53, 53, 53, 1);
const Color greyTextColor = Color.fromRGBO(99, 99, 99, 1);
const Color greyColor = Color.fromRGBO(191, 191, 191, 1);
const Color greyColorWithOpacity = Color.fromRGBO(245, 245, 245, 1);
const Color starColor = Color.fromRGBO(255, 193, 33, 1);

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
      headlineMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 1.7, height: 1),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: textColor, height: 1),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: textColor, height: 1),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color.fromRGBO(191, 191, 191, 1), height: 1),
      bodyLarge: TextStyle(fontSize: 16, color: textColor, height: 1),
      bodyMedium: TextStyle(fontSize: 12, color: textColor, height: 1),
      bodySmall: TextStyle(fontSize: 14, color: Color.fromRGBO(191, 191, 191, 1), height: 1),
      labelLarge: TextStyle(fontSize: 14, color: Color.fromRGBO(191, 191, 191, 1), fontWeight: FontWeight.bold, height: 1),
      labelMedium: TextStyle(fontSize: 12, color: Color.fromRGBO(191, 191, 191, 1), fontWeight: FontWeight.bold, height: 1)),
  iconTheme: const IconThemeData(color: Color.fromRGBO(96, 96, 96, 1)),
  cardColor: Color.fromARGB(255, 245, 245, 245),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallBorderRadius))),
          textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 16)))),
  appBarTheme: const AppBarTheme(backgroundColor: backgroundCardColor, foregroundColor: Color.fromRGBO(96, 96, 96, 1)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: backgroundCardColor,
    padding: EdgeInsets.all(10),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    shape: CircleBorder(),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return primaryColor;
      }
      return greyColor;
    }),
    thumbColor: const WidgetStatePropertyAll(onPrimaryColor),
    trackOutlineColor: WidgetStateColor.transparent
  )
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallBorderRadius))),
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