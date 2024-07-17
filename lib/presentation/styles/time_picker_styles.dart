import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';

InputDecoration timePickerInputStyle = InputDecoration(
  hintText: "00",
  filled: true,
  fillColor: Colors.grey[200],
  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(mediumBorderRadius)),
    borderSide: BorderSide(
      width: 2.0,
      color: comfirmBtnColor
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(mediumBorderRadius)),
    borderSide: BorderSide(
      width: 2.0,
      color: Colors.grey[350]!
    )
  ),
  contentPadding: const EdgeInsets.all(10),
  counterText: '',
);

const TextStyle timePickerTextStyle = TextStyle(
  fontSize: 60,
  height: 1,
  fontWeight: FontWeight.bold
);

const TextStyle timePickerInputSeparatorStyle = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
  height: 1.2
);