
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {

  final bool Function() action;

  const DoneButton({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        bool res = action();
        if (res) {
          Navigator.of(context).pop();
        }
      },
      color: const Color.fromARGB(255, 31, 31, 31),
      iconSize: 36.0,
      icon: const Icon(Icons.done),
      // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      style: IconButton.styleFrom(
        backgroundColor: const Color.fromRGBO(118, 253, 172, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        )
      ),
    );
  }
}