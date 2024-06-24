import 'package:flutter/material.dart';

class DoubleDotTimeDivider extends StatelessWidget {
  const DoubleDotTimeDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      ":",
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        height: 1
      ),
    );
  }
}