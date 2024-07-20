import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

const InputDecoration timePickerInputStyle = InputDecoration(
  hintText: "00",
  filled: true,
  fillColor: inputBackgroundColor,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(mediumBorderRadius)),
    borderSide: BorderSide(
      width: baseBorderWidth,
      color: primaryColor
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(mediumBorderRadius)),
    borderSide: BorderSide(
      width: 0,
      color: Colors.transparent
    )
  ),
  focusColor: primaryColor,
  contentPadding: EdgeInsets.all(10),
  counterText: '',
);

const TextStyle timePickerTextStyle = TextStyle(
  fontSize: 54,
  height: 1,
  color: greyTextColor,
  fontFamily: "Fixel",
  fontWeight: FontWeight.w500
);

const TextStyle timePickerInputSeparatorStyle = TextStyle(
  fontSize: 54,
  color: greyTextColor,
  fontFamily: "Fixel",
  fontWeight: FontWeight.w500,
  height: 1.2
);