import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateDoneButtonCardWidget extends StatelessWidget {
  const DateDoneButtonCardWidget({
    super.key,
    required this.screenHeight,
    required this.doneButtonHeight,
    required this.child
  });

  final double screenHeight;
  final double doneButtonHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: screenHeight * doneButtonHeight,
        color: Colors.transparent,
        child: child
      ),
    );
  }
}