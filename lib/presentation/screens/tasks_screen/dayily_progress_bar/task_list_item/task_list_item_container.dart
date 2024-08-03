
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_important_star.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskListItemContainer extends StatelessWidget {
  final TaskListItemData data;

  const TaskListItemContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String startIn = S.of(context).startIn;
    String date = data.date != null ? data.getFomatedDate()! : S.of(context).none;
    String weekDays = data.repetlyDates != null ? data.repeatlyDaysAsStrings(S.of(context))!.join(',') : S.of(context).none;
    String duration = data.duration != null ? "${data.duration!.inHours} ${S.of(context).hours}" : S.of(context).none;
    String reminds = "${S.of(context).remind}: ${data.isRemidresExists() ? S.of(context).yes : S.of(context).no}";

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(mediumBorderRadius), color: Theme.of(context).cardColor),
      child: Stack(clipBehavior: Clip.none, children: [
        if (data.important) const TaskListImportantStar(),
        if (data.color != null) TaskListItemColor(color: data.color!),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Container(
                constraints: const BoxConstraints.expand(width: 230),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.category != null ? data.category! : S.of(context).none,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "$startIn: ${data.getFormatedStartIn(data.startIn, S.of(context))}",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: дописати цей елемент
                  // додато вибір кольору в TaskListItemData і сюди
                  Text(
                    date,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    weekDays,
                    // "Mon, Tue, Sat, Wen, But, Ass",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    duration,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    reminds,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class TaskListItemColor extends StatelessWidget {
  final Color color;

  const TaskListItemColor({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -23,
      top: -18,
      child: Container(
        height: 23,
        width: 23,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).canvasColor),
        alignment: Alignment.center,
        child: Icon(
          Icons.circle,
          color: color,
          size: 15,
        ),
      ),
    );
  }
}