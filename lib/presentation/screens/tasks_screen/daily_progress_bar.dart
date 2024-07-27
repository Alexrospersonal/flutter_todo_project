import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';

class DailyProgressBar extends StatelessWidget {
  const DailyProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: DateInformationTitle()
        ),
        SizedBox(
          width: 25,
        ),
        Flexible(
          flex: 2,
          child: DayliInfoBar()
          )
      ],
    );
  }
}
class DayliInfoBar extends StatelessWidget {
  const DayliInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "75%",
          style: Theme.of(context).textTheme.titleSmall,
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