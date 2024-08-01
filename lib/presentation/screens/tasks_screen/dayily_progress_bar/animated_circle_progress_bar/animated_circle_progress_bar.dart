import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class AnimatedCircleProgressBar extends CustomPainter {
  final double value;
  final double percent;

  AnimatedCircleProgressBar({required this.value, required this.percent});

  void addBaseStyleForCircle(Paint paint, Color color) {
    paint.style = PaintingStyle.stroke;
    paint.color = color;
    paint.strokeWidth = 18;
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    Rect rect = const Rect.fromLTRB(0, 0, 140, 140);
    final offset = const Offset(9, 9) & Size(size.width - 18, size.height - 18);

    final Gradient gradient = SweepGradient(
      startAngle: 0,
      endAngle: pi * 2,
      colors: const [
        greyColorWithOpacity,
        primaryColorWithOpacity,
        primaryColor,
      ],
      stops: const [0.05, 0.15, 1],
      transform: GradientRotation(percent == 1 ? value - (pi / 2) : -1.75),
    );

    Paint filledPaint = Paint();
    addBaseStyleForCircle(filledPaint, greyColorWithOpacity);
    canvas.drawArc(offset, -pi / 2, pi * 2, false, filledPaint);

    Paint circlePaint = Paint();
    addBaseStyleForCircle(circlePaint, Colors.black);
    circlePaint.strokeCap = StrokeCap.round;
    circlePaint.shader = gradient.createShader(rect);
    canvas.drawArc(offset, -pi / 2, value, false, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
