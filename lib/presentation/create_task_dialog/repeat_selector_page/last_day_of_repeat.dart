import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/generic_picker_dialog.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class LastDayOfRepeat extends StatefulWidget {
  const LastDayOfRepeat({
    super.key,
  });

  @override
  State<LastDayOfRepeat> createState() => _LastDayOfRepeatState();
}

class _LastDayOfRepeatState extends State<LastDayOfRepeat> {
  void callShowGeneralDialog(BuildContext parentContext) {
    showGeneralDialog(
      context: parentContext,
      barrierDismissible: false,
      barrierLabel: "Add Task",
      barrierColor: Colors.white.withOpacity(0.5),
      pageBuilder: (context, anim1, anim2) {
        return ChangeNotifierProvider.value(
          value: parentContext.read<TaskState>(),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
              child: PickEndOfDateDialog(parentContext: parentContext)),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEnabled = context.watch<LastDayOfRepeatNotifier>().isEnabled;

    BuildContext parentContext = context;

    return AdditionalSettingsPageHeader(
      text: S.of(context).lastDayOfRepeat,
      iconData: Icons.add,
      state: isEnabled,
      callback: (bool state) {
        if (state) {
          callShowGeneralDialog(parentContext);
        }
        context.read<LastDayOfRepeatNotifier>().setIsLastDayOfRepeat(state);
      },
    );
  }
}

class PickEndOfDateDialog extends StatefulWidget {
  final BuildContext parentContext;

  const PickEndOfDateDialog({super.key, required this.parentContext});

  @override
  State<PickEndOfDateDialog> createState() => _PickEndOfDateDialogState();
}

class _PickEndOfDateDialogState extends State<PickEndOfDateDialog> {
  @override
  Widget build(BuildContext context) {
    widget.parentContext.watch<LastDayOfRepeatNotifier>().lastDate;

    return GenericPickerDialog(
      height: 400,
      callback: () {},
      children: [
        Container(
          // height: 500,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumBorderRadius),
            color: Theme.of(context).canvasColor,
          ),
          // TODO: проблеми з календарем. Виправити помилку.
          child: CalendarWidget<TaskState>(
              weekdays:
                  widget.parentContext.watch<RepeatlyNotifier>().repeatOfDays,
              recurringEndDate: widget.parentContext
                  .watch<LastDayOfRepeatNotifier>()
                  .lastDate,
              changeDate: (DateTime selectedDay) {
                widget.parentContext
                    .read<LastDayOfRepeatNotifier>()
                    .setLastDate(selectedDay);
              }),
        )
      ],
    );
  }
}
