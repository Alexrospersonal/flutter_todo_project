import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';

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
          const ExpandedCircleProgressDetailsBar(
            percent: 0.66,
          )
      ],
    );
  }
}

class ExpandedCircleProgressDetailsBar extends StatefulWidget {
  final double percent;
  const ExpandedCircleProgressDetailsBar({super.key, required this.percent});

  @override
  State<ExpandedCircleProgressDetailsBar> createState() => _ExpandedCircleProgressDetailsBarState();
}

class _ExpandedCircleProgressDetailsBarState extends State<ExpandedCircleProgressDetailsBar>
    with SingleTickerProviderStateMixin {
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
    canvas.drawArc(Offset(5.5, 5.5) & Size(size.width - 5 - 6, size.height - 5 - 6), pi * 2 * percent - (pi / 2),
        pi * 2 * (1.0 - percent), false, filedPainter);

    final feelPainter = Paint();
    feelPainter.color = Colors.blue;
    feelPainter.style = PaintingStyle.stroke;
    feelPainter.strokeWidth = 5;
    feelPainter.strokeCap = StrokeCap.round;
    canvas.drawArc(Offset(5.5, 5.5) & Size(size.width - 5 - 6, size.height - 5 - 6), -pi / 2, pi * 2 * percent, false,
        feelPainter);

    // ui.TextStyle textStyle = ui.TextStyle(color: Colors.red);

    // ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
    //     ui.ParagraphStyle(fontSize: 18, fontWeight: FontWeight.bold));
    // paragraphBuilder.pushStyle(textStyle);

    // paragraphBuilder.addText("100%");

    // ui.Paragraph paragraph = paragraphBuilder.build();
    // ui.ParagraphConstraints paragraphConstraints =
    //     ui.ParagraphConstraints(width: size.width);
    // paragraph.layout(ui.ParagraphConstraints(width: size.width));

    // canvas.drawParagraph(paragraph, Offset(size.width / 2, size.height / 2));
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
