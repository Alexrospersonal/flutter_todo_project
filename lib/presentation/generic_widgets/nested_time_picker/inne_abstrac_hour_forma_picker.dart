import 'package:flutter/material.dart';

abstract interface  class InnerAbstractHourFormatPicker extends Widget{
  final void Function(TimeOfDay time) callback;
  final DateTime initialDate;

  const InnerAbstractHourFormatPicker({
    super.key,
    required this.callback,
    required this.initialDate
  });
}
