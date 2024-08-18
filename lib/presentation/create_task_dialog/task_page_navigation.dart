import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_dialog_display_switch.dart';

class TaskPageNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const TaskPageNavigation(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 510, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TaskDialogDisplaySwitch(
            index: 0,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalInfoLabel,
            iconData: Icons.menu,
          ),
          TaskDialogDisplaySwitch(
            index: 1,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalDateLabel,
            iconData: Icons.calendar_month,
          ),
          TaskDialogDisplaySwitch(
            index: 2,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalTimeLabel,
            iconData: Icons.schedule_rounded,
          ),
          TaskDialogDisplaySwitch(
            index: 3,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalDurationLabel,
            iconData: Icons.timer,
          ),
          TaskDialogDisplaySwitch(
            index: 4,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalNotificationLabel,
            iconData: Icons.notifications,
          ),
          TaskDialogDisplaySwitch(
            index: 5,
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
            buttonName: S.of(context).additionalRepeatLabel,
            iconData: Icons.repeat,
          ),
        ],
      ),
    );
  }
}
