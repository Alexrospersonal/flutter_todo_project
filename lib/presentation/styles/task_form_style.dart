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
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(34)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: -5)],
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white60, Colors.white10]),
            borderRadius: const BorderRadius.all(Radius.circular(34)),
            border: Border.all(width: 2, color: Colors.white30)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: children,
              )
            )
          ),
        ),
      ),
    );
  }
}
