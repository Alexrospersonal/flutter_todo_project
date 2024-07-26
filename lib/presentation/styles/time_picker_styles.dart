import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

const InputDecoration timePickerInputStyle = InputDecoration(
  hintText: "00",
  filled: true,
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
  contentPadding: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 0),
  counterText: '',
);

const TextStyle timePickerTextStyle = TextStyle(
  fontSize: 52,
  height: 1.2,
  color: greyTextColor,
  fontWeight: FontWeight.w500
);

const TextStyle timePickerInputSeparatorStyle = TextStyle(
  fontSize: 56,
  color: greyTextColor,
  fontWeight: FontWeight.w500,
  height: 1.3
);