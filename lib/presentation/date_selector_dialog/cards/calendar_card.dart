import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_date_notifier.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_repeat_notifier.dart';
import 'package:flutter_todo_project/domain/utils/format.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings_page_header.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    DateTime? date = context.watch<TaskDateNotifier>().taskDateTime;

    return Selector<TaskDateNotifier, bool>(
      selector: (context, state) => state.isEnabled,
      builder: (context, hasDate, child) {
        return Column(
          children: [
            AdditionalSettingsPageHeader(
              text:
                  date != null ? formatDate(locale, date) : S.of(context).none,
              iconData: Icons.calendar_month,
              state: hasDate,
              callback: (bool state) {
                context.read<TaskDateNotifier>().setHasDate(state);
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
                    child: CalendarWidget<TaskDateNotifier>(
                        weekdays: context.read<RepeatlyNotifier>().repeatOfDays,
                        recurringEndDate:
                            context.watch<LastDayOfRepeatNotifier>().lastDate,
                        changeDate: (DateTime selectedDay) {
                          context.read<TaskDateNotifier>().setDate(selectedDay);
                        })),
              ),
            )
          ],
        );
      },
    );
  }
}
