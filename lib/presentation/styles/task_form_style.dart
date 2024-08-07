import 'dart:ui';

import 'package:flutter/material.dart';

class DialogTaskFormBackgroundStyle extends StatelessWidget {
  final List<Widget> children;

  const DialogTaskFormBackgroundStyle({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: children,
      )
    );
  }
}
