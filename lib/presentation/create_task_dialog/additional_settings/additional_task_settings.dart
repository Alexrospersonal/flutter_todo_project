import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/domain/utils/format.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_button.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_container.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_info_field.dart';
import 'package:provider/provider.dart';

class AdditionalTaskSetting extends ConsumerStatefulWidget {
  final void Function(int) onItemTapped;

  const AdditionalTaskSetting({super.key, required this.onItemTapped});

  @override
  ConsumerState<AdditionalTaskSetting> createState() =>
      _AdditionalTaskSettingState();
}

class _AdditionalTaskSettingState extends ConsumerState<AdditionalTaskSetting> {
  void switchExpanded(bool isExpanded) {
    ref.read(initialTaskDialogExpandedProvider.notifier).state = !isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(initialTaskDialogExpandedProvider);
    Locale locale = Localizations.localeOf(context);
    var date = context.read<TaskState>().taskDateTime;
    var time = context.read<TaskTimeNotifier>().taskDateTime;

    var repeatOfDays = context.watch<RepeatlyNotifier>().repeatOfDays;
    var repetOfTimes = context.watch<RepeatInTimeNotifier>().times;

    var weekDaysAsStrings = repeatlyDaysAsStrings(S.of(context), repeatOfDays);
    var timesAsString = repeatlyTimesAsStrings(repetOfTimes);

    var repeatedlyString =
        "${weekDaysAsStrings.join(",")} ${timesAsString.join("|")}";

    List<Widget> additionalParams = [
      AdditionalSettingInput(
        buttonLabel: date != null
            ? formatDate(locale, date)
            : S.of(context).additionalDateLabel,
        state: context.watch<TaskState>().canEnabled,
        icon: Icons.calendar_month,
        callback: (bool state) {
          context.read<TaskState>().setHasDate(state);
          if (state) {
            widget.onItemTapped(1);
          }
        },
      ),
      AdditionalSettingInput(
        buttonLabel: time != null
            ? formatTime(time, context)
            : S.of(context).additionalTimeLabel,
        state: context.watch<TaskTimeNotifier>().isEnabled,
        icon: Icons.schedule_rounded,
        callback: (bool state) {
          context.read<TaskTimeNotifier>().setIsEnabled(state);
          if (state) {
            widget.onItemTapped(2);
          }
        },
      ),
      AdditionalSettingInput(
        buttonLabel: (weekDaysAsStrings.isNotEmpty &&
                context.read<RepeatlyNotifier>().isEnabled)
            ? repeatedlyString
            : S.of(context).additionalRepeatLabel,
        state: context.watch<RepeatlyNotifier>().isEnabled,
        icon: Icons.repeat,
        callback: (bool state) {
          context.read<RepeatlyNotifier>().setIsRepeatOfDays(state);
          if (state) {
            widget.onItemTapped(3);
          }
        },
      ),
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalNotificationLabel,
        state: false,
        icon: Icons.notifications,
        callback: (bool state) {},
      ),
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalDurationLabel,
        state: false,
        icon: Icons.timer,
        callback: (bool state) {},
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: isExpanded
            ? AdditionalSettingsContainer(
                callback: () => switchExpanded(isExpanded),
                children: additionalParams)
            : AdditionalSettingsButton(
                callback: () => switchExpanded(isExpanded)),
      ),
    );
  }
}
