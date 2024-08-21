import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/dialog_snack_bar_controller.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});

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

  void callSnackBar(BuildContext dialogContext) {
    const snackBar = SnackBar(
      content: Text("TESt SNACK BAR"),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(dialogContext).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    DateTime? date = context.watch<TaskState>().taskDateTime;

    return Selector<TaskState, bool>(
      selector: (context, state) => state.canEnabled,
      builder: (context, hasDate, child) {
        return Column(
          children: [
            AdditionalSettingsPageHeader(
              text:
                  date != null ? formatDate(locale, date) : S.of(context).none,
              iconData: Icons.calendar_month,
              state: hasDate,
              callback: (bool state) {
                context.read<TaskState>().setHasDate(state);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 390,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mediumBorderRadius),
                color: Theme.of(context).canvasColor,
              ),
              child: Opacity(
                opacity: hasDate ? 1 : 0.5,
                child: IgnorePointer(
                    ignoring: hasDate ? false : true,
                    child: CalendarWidget<TaskState>(
                        weekdays: context.read<RepeatlyNotifier>().repeatOfDays,
                        recurringEndDate:
                            context.watch<LastDayOfRepeatNotifier>().lastDate,
                        changeDate: (DateTime selectedDay) {
                          context.read<TaskState>().setDate(selectedDay);
                        })),
              ),
            )
          ],
        );
      },
    );
  }
}
