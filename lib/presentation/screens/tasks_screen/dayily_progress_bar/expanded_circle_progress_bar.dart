import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/animated_circle_progress_bar/animated_circle_progress_bar.dart';

class ExpandedCircleProgressBar extends StatefulWidget {
  final double percent;
  const ExpandedCircleProgressBar({super.key, required this.percent});

  @override
  State<ExpandedCircleProgressBar> createState() => _ExpandedCircleProgressBarState();
}

class _ExpandedCircleProgressBarState extends State<ExpandedCircleProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> gradientAnimation;
  late Animation<double> percentAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    final curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);

    gradientAnimation = Tween<double>(begin: 0, end: pi * 2 * widget.percent).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    percentAnimation = Tween<double>(begin: 0, end: widget.percent * 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child: CustomPaint(
                painter: AnimatedCircleProgressBar(value: gradientAnimation.value, percent: widget.percent),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "${percentAnimation.value.toInt().toString().padLeft(2, '0')}%",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    S.of(context).monthProgress,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
