import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/repeat_selector_page/pick_end_of_date_dialog.dart';
import 'package:intl/intl.dart';
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: parentContext.watch<TaskState>(),
            ),
            ChangeNotifierProvider.value(
              value: parentContext.watch<RepeatlyNotifier>(),
            ),
            ChangeNotifierProvider.value(
              value: parentContext.watch<LastDayOfRepeatNotifier>(),
            )
          ],
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
              child: const PickEndOfDateDialog()),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
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

  @override
  Widget build(BuildContext context) {
    bool isEnabled = context.watch<LastDayOfRepeatNotifier>().isEnabled;
    Locale locale = Localizations.localeOf(context);
    DateTime? lastDayOfRepeat =
        context.watch<LastDayOfRepeatNotifier>().lastDate;

    String text = lastDayOfRepeat != null
        ? formatDate(locale, lastDayOfRepeat)
        : S.of(context).lastDayOfRepeat;

    IconData icon = lastDayOfRepeat != null ? Icons.edit : Icons.add;

    return AdditionalSettingsPageHeader(
      text: text,
      iconData: icon,
      state: isEnabled,
      tapOnLabel: () {
        bool isEnabled = context.read<LastDayOfRepeatNotifier>().isEnabled;
        if (isEnabled) {
          callShowGeneralDialog(context);
        }
      },
      callback: (bool state) {
        var result =
            context.read<LastDayOfRepeatNotifier>().setIsLastDayOfRepeat(state);

        if (result && state) {
          callShowGeneralDialog(context);
        }
      },
    );
  }
}
