import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_time_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_button.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// TODO: Рефакторінг зробити
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

  String formatDate(Locale locale, DateTime date) {
    late DateFormat dateFormat;

    switch (locale.countryCode) {
      case 'US':
        dateFormat = DateFormat('MM/dd/yyyy');
      case 'GB':
        dateFormat = DateFormat('dd/MM/yyyy');
      default:
        dateFormat = DateFormat('dd/MM/yyyy');
    }

    return dateFormat.format(date);
  }

  String formatTime(DateTime time) {
    final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    if (is24HourFormat) {
      return "${time.hour}:${time.minute}";
    }
    return DateFormat("hh:mm a", "en_US").format(time);
  }

  List<String> repeatlyDaysAsStrings(S s, List<bool> repetlyDates) {
    final dateFormat = DateFormat('EEE');

    final List<String> formattedDates = repetlyDates
        .asMap()
        .entries
        .where((entry) => entry.value) // Фільтруємо записи, де значення true
        .map((entry) {
      final date = DateTime.utc(2024, 1, 1).add(Duration(days: entry.key));
      return dateFormat.format(date); // Форматуємо дату
    }).toList(); // Перетворюємо результат в список

    if (formattedDates.length == 7) {
      return [s.week];
    }
    return formattedDates.isEmpty ? [s.none] : formattedDates;
  }

  List<String> repeatlyTimesAsStrings(List<DateTime?> times) {
    return times.map<String>((date) {
      return date != null ? "X" : "-";
    }).toList();
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
        buttonLabel:
            time != null ? formatTime(time) : S.of(context).additionalTimeLabel,
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

class AdditionalSettingInput extends StatefulWidget {
  final String buttonLabel;
  final IconData icon;
  final bool state;
  final void Function(bool state) callback;

  const AdditionalSettingInput(
      {super.key,
      required this.buttonLabel,
      required this.icon,
      required this.state,
      required this.callback});

  @override
  State<AdditionalSettingInput> createState() => _AdditionalSettingInputState();
}

class _AdditionalSettingInputState extends State<AdditionalSettingInput> {
  // bool state = false;

  @override
  Widget build(BuildContext context) {
    var offTextStyle = Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(fontWeight: FontWeight.normal);
    var onTextStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSurface);

    Color iconColor = widget.state ? onTextStyle.color! : offTextStyle.color!;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 32,
              child: ElevatedButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10))),
                onPressed: () => widget.callback(true),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.buttonLabel,
                        style: widget.state ? onTextStyle : offTextStyle),
                    Icon(
                      widget.icon,
                      color: iconColor,
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        Switch(
          value: widget.state,
          onChanged: (value) {
            widget.callback(value);
          },
        )
      ],
    );
  }
}
