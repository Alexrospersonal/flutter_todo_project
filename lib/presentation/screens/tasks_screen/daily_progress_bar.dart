import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class DailyProgressBar extends StatefulWidget {
  const DailyProgressBar({super.key});

  @override
  State<DailyProgressBar> createState() => _DailyProgressBarState();
}

class _DailyProgressBarState extends State<DailyProgressBar> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(flex: 4, child: DateInformationTitle()),
            const SizedBox(
              width: 25,
            ),
            Flexible(
                flex: 2,
                child: GestureDetector(
                    onTap: () => setState(() {
                          isExpanded = !isExpanded;
                        }),
                    child: const DailyInfoBar()))
          ],
        ),
        if (isExpanded)
          Row(
            children: [
              const ExpandedCircleProgressDetailsBar(
                percent: 0.66,
              ),
              const ExpandedDiagramWeekDetails()
            ],
          )
      ],
    );
  }
}

class ExpandedDiagramWeekDetails extends StatefulWidget {
  const ExpandedDiagramWeekDetails({super.key});

  @override
  State<ExpandedDiagramWeekDetails> createState() => _ExpandedDiagramWeekDetailsState();
}

class _ExpandedDiagramWeekDetailsState extends State<ExpandedDiagramWeekDetails> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late Animation<double> animation5;
  late Animation<double> animation6;
  late Animation<double> animation7;

  List<double> percentData = [0.75, 1, 0.23, 1, 0.56, 0.66, 0.89];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    final curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);

    animation1 = Tween<double>(begin: 0, end: percentData[0]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation2 = Tween<double>(begin: 0, end: percentData[1]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation3 = Tween<double>(begin: 0, end: percentData[2]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation4 = Tween<double>(begin: 0, end: percentData[3]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation5 = Tween<double>(begin: 0, end: percentData[4]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation6 = Tween<double>(begin: 0, end: percentData[5]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    animation7 = Tween<double>(begin: 0, end: percentData[6]).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 140,
      child: CustomPaint(
        painter: AnimatedWeekProgressDiagramm(progressInWeek: [
          animation1.value,
          animation2.value,
          animation3.value,
          animation4.value,
          animation5.value,
          animation6.value,
          animation7.value
        ]),
      ),
    );
  }
}

class AnimatedWeekProgressDiagramm extends CustomPainter {
  final List<double> progressInWeek;

  AnimatedWeekProgressDiagramm({required this.progressInWeek});

  ui.ParagraphBuilder createParagraphBuilder(ui.TextStyle textStyle, double fontSize) {
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: fontSize, fontWeight: FontWeight.w500));
    paragraphBuilder.pushStyle(textStyle);

    return paragraphBuilder;
  }

  ui.Paragraph getParagraph(ui.ParagraphBuilder paragraphBuilder, double constraintWidth) {
    ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: constraintWidth));

    return paragraph;
  }

  ui.ParagraphBuilder addText(String text) {
    var builder = createParagraphBuilder(
      textStyle,
      10,
    );

    builder.addText(text);

    return builder;
  }

  var textStyle = ui.TextStyle(color: greyColor, fontSize: 10, height: 1);

  double calculatePercentage(double percent) {
    // Значення на 0% та 100%
    double minValue = 112.4; // Значення при 0%
    double maxValue = 10; // Значення при 100%

    // Лінійна інтерполяція
    double value = minValue + (maxValue - minValue) * (percent / 100);

    return value;
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    double column = size.width / 4 - 15;
    double row = size.height / 5 - 1;
    double lineWidth = size.width - column - 10;
    double weekColumn = lineWidth / 7;

    Paint line = Paint();
    line.color = greyColor;
    line.style = PaintingStyle.stroke;
    line.strokeWidth = 1;

    Paint diagramLine = Paint();
    diagramLine.style = PaintingStyle.stroke;
    diagramLine.color = Colors.black;
    diagramLine.strokeCap = StrokeCap.round;
    diagramLine.strokeWidth = 12;

    double x = column + weekColumn - 4;

    double startY = size.height - row;

    Rect rect = const Rect.fromLTRB(0, 0, 180, 140);

    Gradient gradient = const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        onPrimaryColor,
        primaryColorWithOpacity,
        primaryColor,
      ],
      stops: [0.2, 0.6, 1],
    );

    diagramLine.shader = gradient.createShader(rect);

    canvas.drawLine(
      Offset(x, startY),
      Offset(x, calculatePercentage(progressInWeek[0] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 1, startY),
      Offset(x + weekColumn * 1, calculatePercentage(progressInWeek[1] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 2, startY),
      Offset(x + weekColumn * 2, calculatePercentage(progressInWeek[2] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 3, startY),
      Offset(x + weekColumn * 3, calculatePercentage(progressInWeek[3] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 4, startY),
      Offset(x + weekColumn * 4, calculatePercentage(progressInWeek[4] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 5, startY),
      Offset(x + weekColumn * 5, calculatePercentage(progressInWeek[5] * 100)),
      diagramLine,
    );

    canvas.drawLine(
      Offset(x + weekColumn * 6, startY),
      Offset(x + weekColumn * 6, calculatePercentage(progressInWeek[6] * 100)),
      diagramLine,
    );

    var percent0 = getParagraph(addText("0%"), 15);
    canvas.drawParagraph(percent0, Offset(column - percent0.width, (size.height - row) - percent0.height / 2));
    canvas.drawLine(Offset(column, size.height - row), Offset(size.width, size.height - row), line);

    var percent25 = getParagraph(addText("25%"), 20);
    canvas.drawParagraph(percent25, Offset(column - percent25.width, (size.height - row * 2) - percent25.height / 2));
    canvas.drawLine(Offset(column, size.height - row * 2), Offset(size.width, size.height - row * 2), line);

    var percent50 = getParagraph(addText("50%"), 20);
    canvas.drawParagraph(percent50, Offset(column - percent50.width, (size.height - row * 3) - percent50.height / 2));
    canvas.drawLine(Offset(column, size.height - row * 3), Offset(size.width, size.height - row * 3), line);

    var percent75 = getParagraph(addText("75%"), 20);
    canvas.drawParagraph(percent75, Offset(column - percent75.width, (size.height - row * 4) - percent75.height / 2));
    canvas.drawLine(Offset(column, size.height - row * 4), Offset(size.width, size.height - row * 4), line);

    var percent100 = getParagraph(addText("100%"), 25);
    canvas.drawParagraph(percent100, Offset(column - percent100.width, (size.height - row * 5) - percent100.height / 2));
    canvas.drawLine(Offset(column, size.height - row * 5), Offset(size.width, size.height - row * 5), line);

    canvas.save(); // Зберігає поточний стан
    canvas.translate(size.width, size.height); // Перемістіть у центр
    canvas.rotate(-pi / 2);

    var mon = getParagraph(addText("Mon"), 20);
    canvas.drawParagraph(mon, Offset(2, weekColumn * -7));

    var tue = getParagraph(addText("Tue"), 20);
    canvas.drawParagraph(tue, Offset(5, weekColumn * -6));

    var wen = getParagraph(addText("Wen"), 20);
    canvas.drawParagraph(wen, Offset(2, weekColumn * -5));

    var thu = getParagraph(addText("Thu"), 20);
    canvas.drawParagraph(thu, Offset(4, weekColumn * -4));

    var fri = getParagraph(addText("Fri"), 20);
    canvas.drawParagraph(fri, Offset(10, weekColumn * -3));

    var sat = getParagraph(addText("Sat"), 20);
    canvas.drawParagraph(sat, Offset(7, weekColumn * -2));

    var sun = getParagraph(addText("Sun"), 20);
    canvas.drawParagraph(sun, Offset(5, weekColumn * -1));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ExpandedCircleProgressDetailsBar extends StatefulWidget {
  final double percent;
  const ExpandedCircleProgressDetailsBar({super.key, required this.percent});

  @override
  State<ExpandedCircleProgressDetailsBar> createState() => _ExpandedCircleProgressDetailsBarState();
}

class _ExpandedCircleProgressDetailsBarState extends State<ExpandedCircleProgressDetailsBar> with SingleTickerProviderStateMixin {
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
                    "Month progress",
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

class MyPainter extends CustomPainter {
  final double percent = 0.62;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPainter = Paint();
    backgroundPainter.color = Colors.black;
    backgroundPainter.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPainter);

    final filedPainter = Paint();
    filedPainter.color = Colors.yellow;
    filedPainter.style = PaintingStyle.stroke;
    filedPainter.strokeWidth = 5;
    canvas.drawArc(Offset(5.5, 5.5) & Size(size.width - 5 - 6, size.height - 5 - 6), pi * 2 * percent - (pi / 2), pi * 2 * (1.0 - percent),
        false, filedPainter);

    final feelPainter = Paint();
    feelPainter.color = Colors.blue;
    feelPainter.style = PaintingStyle.stroke;
    feelPainter.strokeWidth = 5;
    feelPainter.strokeCap = StrokeCap.round;

    canvas.drawArc(Offset(5.5, 5.5) & Size(size.width - 5 - 6, size.height - 5 - 6), -pi / 2, pi * 2 * percent, false, feelPainter);

    ui.TextStyle textStyle = ui.TextStyle(color: Colors.red);

    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: 18, fontWeight: FontWeight.bold));
    paragraphBuilder.pushStyle(textStyle);

    paragraphBuilder.addText("100%");

    ui.Paragraph paragraph = paragraphBuilder.build();
    ui.ParagraphConstraints paragraphConstraints = ui.ParagraphConstraints(width: size.width);
    paragraph.layout(ui.ParagraphConstraints(width: size.width));

    canvas.drawParagraph(paragraph, Offset(size.width / 2, size.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DailyInfoBar extends StatelessWidget {
  const DailyInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "75%",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor,
              size: 21,
            )
          ],
        ),
        const LinearProgressIndicator(
          value: 0.75,
          semanticsLabel: 'daily progress indicator',
          minHeight: 4,
          backgroundColor: backgroundCardColor,
        ),
        Text(
          S.of(context).dailyProgress,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}

class DateInformationTitle extends StatelessWidget {
  const DateInformationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<String> fomatedDate = DateFormat('EEE MMM').format(today).split(' ');
    String text = "${fomatedDate[0]} ${today.day} ${fomatedDate[1]}";

    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
