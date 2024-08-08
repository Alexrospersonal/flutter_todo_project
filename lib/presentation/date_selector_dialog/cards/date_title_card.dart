import 'package:flutter/material.dart';

class DateTitleCardWidget extends StatelessWidget {
  const DateTitleCardWidget({
    super.key,
    required this.screenHeight,
    required this.titleHeight,
    required this.child
  });

  final Widget child;
  final double screenHeight;
  final double titleHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * titleHeight,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: child,
    );
  }
}