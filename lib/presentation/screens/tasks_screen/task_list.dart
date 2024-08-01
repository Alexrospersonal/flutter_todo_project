import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/screens/tasks_screen/dayily_progress_bar/task_list_item/task_list_item_data.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:intl/intl.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({super.key});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // child: AnimatedList(),
      child: Dismissible(
        key: ValueKey<int>(0),
        direction: DismissDirection.startToEnd,
        child: TaskListItemContainer(
          data: buildTask(),
        ),
      ),
    );
  }
}

class TaskListItemContainer extends StatelessWidget {
  final TaskListItemData data;

  const TaskListItemContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String startIn = S.of(context).startIn;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 13),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(mediumBorderRadius), color: Theme.of(context).cardColor),
      child: Stack(clipBehavior: Clip.none, children: [
        if (data.important) const ImportantStar(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.category != null ? data.category! : S.of(context).none,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Text(
                    data.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  "$startIn: ${data.getFormatedStartIn(data.startIn, S.of(context))}",
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: дописати цей елемент
                // додати локалізацію
                // додато вибір кольору в TaskListItemData і сюди

                Text(
                  "18:00  27/07/2024",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "Mon, Tue, Sat, Wen, But, Ass",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "7 hours",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "Remind in: 2 days",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}

class ImportantStar extends StatelessWidget {
  const ImportantStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -20,
      top: 32 - 16,
      child: Container(
        height: 16,
        width: 16,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).canvasColor),
        alignment: Alignment.center,
        child: const Icon(
          Icons.star_rounded,
          color: starColor,
          size: 12,
        ),
      ),
    );
  }
}
