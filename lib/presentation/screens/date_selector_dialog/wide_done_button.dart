import 'package:flutter/material.dart';

class WideDoneButton extends StatelessWidget {
  final Function action;

  const WideDoneButton({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: IconButton.filled(
        onPressed: () {
          action();
          Navigator.of(context).pop();
        },
        padding: const EdgeInsets.all(0),
        color: const Color.fromARGB(255, 31, 31, 31),
        iconSize: 36.0,
        icon: const Icon(Icons.done),
        style: IconButton.styleFrom(
          backgroundColor: const Color.fromRGBO(118, 253, 172, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
              color: Color.fromARGB(255, 225, 255, 237),
              width: 1
            )
          ),
        ),
      ),
    );
  }
}