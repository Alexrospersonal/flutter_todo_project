import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/animated_week_progress_diagram/animated_week_progress_diagram.dart';

class ExpandedDiagramWeekDetails extends StatefulWidget {
  const ExpandedDiagramWeekDetails({super.key});

  @override
  State<ExpandedDiagramWeekDetails> createState() => _ExpandedDiagramWeekDetailsState();
}

class _ExpandedDiagramWeekDetailsState extends State<ExpandedDiagramWeekDetails> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  List<double> percentData = [0.75, 1, 0.23, 1, 0.56, 0.66, 0.89];
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    final curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);

    animations = percentData.map((maxValue) {
      return Tween<double>(begin: 0, end: maxValue).animate(curvedAnimation)
        ..addListener(() {
          setState(() {});
        });
    }).toList();

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<double> progressInWeek = animations.map((animation) => animation.value).toList();

    return SizedBox(
      height: 140,
      child: CustomPaint(
        painter: AnimatedWeekProgressDiagramm(progressInWeek: progressInWeek),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
