import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/animated_week_progress_diagram/animated_week_progress_data.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class AnimatedWeekProgressDiagramm extends CustomPainter {
  final List<double> progressInWeek;
  final paintData = AnimatedWeekProgressDiagrammData();

  AnimatedWeekProgressDiagramm({required this.progressInWeek});

  double calculatePercentage(double percent) {
    double minValue = 112.4; // 0%
    double maxValue = 10; // 100%

    double value = minValue + (maxValue - minValue) * (percent / 100);

    return value;
  }

  void drawDiagramLine(ui.Canvas canvas, Offset startPoint, Offset endPoint, Paint paint) {
    canvas.drawLine(
      startPoint,
      endPoint,
      paint,
    );
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    double column = size.width / 4;
    double row = size.height / 5 - 1;
    double lineWidth = size.width - column;
    double weekColumn = lineWidth / 7 - (lineWidth / 110);

    Paint line = Paint()
      ..color = greyColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint diagramLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    drawDiagramPicks(column, weekColumn, size, row, diagramLine, paintData, canvas);

    drawBackgroundGrid(paintData, column, size, row, canvas, line);

    canvas.save();
    canvas.translate(size.width, size.height);
    canvas.rotate(-pi / 2);

    drawWeekDays(paintData, canvas, weekColumn);

    canvas.restore();
  }

  void drawBackgroundGrid(
      AnimatedWeekProgressDiagrammData paintData, double column, ui.Size size, double row, ui.Canvas canvas, ui.Paint line) {
    var percents = paintData.percents;
    var percentTextWidth = paintData.percentTextWidth;

    for (var i = 0; i < percents.length; i++) {
      var text = paintData.getParagraph(paintData.addText(percents[i]), percentTextWidth[i]);
      Offset startPoint = Offset(column - text.width, (size.height - row * (i + 1)) - text.height / 2);
      canvas.drawParagraph(text, startPoint);
    }

    for (var i = 0; i < percents.length; i++) {
      canvas.drawLine(Offset(column, size.height - row * (i + 1)), Offset(size.width, size.height - row * (i + 1)), line);
    }
  }

  void drawDiagramPicks(double column, double weekColumn, ui.Size size, double row, ui.Paint diagramLine,
      AnimatedWeekProgressDiagrammData paintData, ui.Canvas canvas) {
    double x = column + weekColumn - 4;

    double startY = size.height - row;

    Rect rect = const Rect.fromLTRB(0, 0, 180, 140);

    diagramLine.shader = paintData.gradient.createShader(rect);

    for (var i = 0; i < progressInWeek.length; i++) {
      drawDiagramLine(canvas, Offset(x + weekColumn * i, startY), Offset(x + weekColumn * i, calculatePercentage(progressInWeek[i] * 100)),
          diagramLine);
    }
  }

  void drawWeekDays(AnimatedWeekProgressDiagrammData paintData, ui.Canvas canvas, double weekColumn) {
    var shortWeekdays = paintData.getShortWeekdays();

    for (var i = 0; i < shortWeekdays.length; i++) {
      var day = paintData.getParagraph(paintData.addText(shortWeekdays[i]), 20);
      canvas.drawParagraph(day, Offset(0, weekColumn * -(i + 1)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
