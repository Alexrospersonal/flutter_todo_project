import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/domain/contollers/dialog_snack_bar_controller.dart';
import 'package:provider/provider.dart';

class RepeatInTimesSelector extends StatelessWidget {
  const RepeatInTimesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnabled = context.watch<RepeatInTimeNotifier>().isEnabled;
    var callInformBar = getCallInformBar(context);

    return AdditionalSettingsPageHeader(
      text: S.of(context).repeatInTime,
      iconData: Icons.repeat,
      state: isEnabled,
      callback: (bool state) {
        var res = context.read<RepeatInTimeNotifier>().setRepeatInTime(state);
        if (!res) {
          callInformBar(SnackBarMessageType.noEnabledRepeatedly);
        }
      },
    );
  }
}
