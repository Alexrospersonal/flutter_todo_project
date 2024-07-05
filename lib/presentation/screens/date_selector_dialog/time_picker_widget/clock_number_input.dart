import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String name;
  final int maxValue;
  final TextEditingController controller;
  final bool enabled;
  final void Function(String) onChanged;

  const NumberInput({
    super.key,
    required this.name,
    required this.maxValue,
    required this.controller,
    required this.enabled,
    required this.onChanged
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 87,
          constraints: const BoxConstraints(
            maxWidth: 160,
            minWidth: 90
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 23, 10, 2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            enabled: widget.enabled,
            maxLength: 2,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChanged,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                final enteredNumber = int.tryParse(newValue.text);
                if (enteredNumber != null && enteredNumber >= widget.maxValue) {
                  return const TextEditingValue(text: '00', selection: TextSelection.collapsed(offset: 2));
                }
                return newValue;
              }),
            ],
            cursorHeight: 60,
            cursorWidth: 2,
            cursorColor: const Color.fromRGBO(118, 253, 172, 1),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "00",
              label: null,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 15)
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
              height: 1
            ),
          ),
        ),
      ],
    );
  }
}