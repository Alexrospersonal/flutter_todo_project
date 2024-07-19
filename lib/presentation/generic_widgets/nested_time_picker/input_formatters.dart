import 'package:flutter/services.dart';

List<TextInputFormatter> getNumberInputFormatters(int maxValue) {
  return [
      FilteringTextInputFormatter.digitsOnly,
      TextInputFormatter.withFunction((oldValue, newValue) {
        final enteredNumber = int.tryParse(newValue.text);

        if (enteredNumber != null && enteredNumber >= maxValue) {
          return const TextEditingValue(text: '');
        }
        return newValue;
      }),
  ];
}