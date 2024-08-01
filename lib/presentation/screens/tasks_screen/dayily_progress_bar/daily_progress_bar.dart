import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/expanded_circle_progress_bar.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/expanded_diagram_weel_details.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/status_and_determinated_info_panel.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';

class DailyProgressBar extends StatefulWidget {
  const DailyProgressBar({super.key});

  @override
  State<DailyProgressBar> createState() => _DailyProgressBarState();
}

class _DailyProgressBarState extends State<DailyProgressBar> with TickerProviderStateMixin {
  bool isExpanded = false;
  double monthProgress = 0.66;
  int determinatedTasks = 7;

  void _toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

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
                    onTap: _toggle,
                    child: DailyInfoBar(
                      isExpanded: isExpanded,
                      percents: monthProgress,
                    )))
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? ExpandedProgressPanel(
                  monthProgress: monthProgress,
                  determinatedTasks: determinatedTasks,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class ExpandedProgressPanel extends StatelessWidget {
  final int determinatedTasks;

  const ExpandedProgressPanel({super.key, required this.monthProgress, required this.determinatedTasks});

  final double monthProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusAndDeterminatedInfoPanel(determinatedTasks: determinatedTasks),
        Row(
          children: [
            ExpandedCircleProgressBar(percent: monthProgress),
            const Expanded(child: ExpandedDiagramWeekDetails()),
          ],
        ),
      ],
    );
  }
}

class DailyInfoBar extends StatefulWidget {
  final bool isExpanded;
  final double percents;

  const DailyInfoBar({super.key, required this.isExpanded, required this.percents});

  @override
  State<DailyInfoBar> createState() => _DailyInfoBarState();
}

class _DailyInfoBarState extends State<DailyInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${(widget.percents * 100).toInt().toString().padLeft(2, '0')}%",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Icon(
              widget.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor,
              size: 21,
            )
          ],
        ),
        LinearProgressIndicator(
          value: widget.percents,
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
