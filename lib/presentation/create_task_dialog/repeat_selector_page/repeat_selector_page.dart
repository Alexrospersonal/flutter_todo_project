import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/last_day_of_repeat.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_in_times_list.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/repeat_in_times_selector.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/weekdays_list.dart';
import 'package:provider/provider.dart';

class RepeatSelectorPage extends StatefulWidget {
  const RepeatSelectorPage({super.key});

  @override
  State<RepeatSelectorPage> createState() => _RepeatSelectorPageState();
}

class _RepeatSelectorPageState extends State<RepeatSelectorPage> {
  @override
  Widget build(BuildContext context) {
    bool isRepeatOfDays = context.watch<RepeatlyNotifier>().isEnabled;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
      child: Column(
        children: [
          AdditionalSettingsPageHeader(
            text: S.of(context).repeatOfdays,
            iconData: Icons.timer,
            state: isRepeatOfDays,
            callback: (bool state) {
              context.read<RepeatlyNotifier>().setIsRepeatOfDays(state);
            },
          ),
          const WeekdaysList(),
          const LastDayOfRepeat(),
          const RepeatInTimesSelector(),
          const RepeatInTimesList(),
        ],
      ),
    );
  }
}
