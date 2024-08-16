import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/repeatly_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:provider/provider.dart';

class LastDayOfRepeat extends StatefulWidget {
  const LastDayOfRepeat({
    super.key,
  });

  @override
  State<LastDayOfRepeat> createState() => _LastDayOfRepeatState();
}

class _LastDayOfRepeatState extends State<LastDayOfRepeat> {
  @override
  Widget build(BuildContext context) {
    return Selector<LastDayOfRepeatNotifier, bool>(
      selector: (context, state) => state.isEnabled,
      builder: (context, isLastDayOfRepeat, child) =>
          AdditionalSettingsPageHeader(
        text: S.of(context).lastDayOfRepeat,
        iconData: Icons.add,
        state: isLastDayOfRepeat,
        callback: (bool state) {
          context.read<LastDayOfRepeatNotifier>().setIsLastDayOfRepeat(state);
        },
      ),
    );
  }
}
