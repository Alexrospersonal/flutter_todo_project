import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/selected_filter_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:flutter_todo_project/settings.dart';

class TasksCategoryFilters extends ConsumerStatefulWidget {
  const TasksCategoryFilters({super.key});

  @override
  ConsumerState<TasksCategoryFilters> createState() => _TasksCategoryFiltersState();
}

class _TasksCategoryFiltersState extends ConsumerState<TasksCategoryFilters> {

  void setFilter(Filter filter) {
    ref.read(selectedFilterIndexProvider.notifier).state = filter;
  }

  @override
  Widget build(BuildContext context) {
    Filter currentFilter = ref.watch(selectedFilterIndexProvider);

    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 7,
      spacing: 16,
      children: [
        TaskCategoryFiltersItem(
          title: S.of(context).newest,
          filter: Filter.newest,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).oldest,
          filter: Filter.oldest,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).isComing,
          filter: Filter.isComing,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).important,
          filter: Filter.important,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).withFiles,
          filter: Filter.withFiles,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).done,
          filter: Filter.done,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
        TaskCategoryFiltersItem(
          title: S.of(context).overdue,
          filter: Filter.overdue,
          currentFilter: currentFilter,
          callback: setFilter,
        ),
      ],
    );
  }
}

class TaskCategoryFiltersItem extends StatelessWidget {
  const TaskCategoryFiltersItem(
      {super.key,
      required this.title,
      required this.filter,
      required this.currentFilter,
      required this.callback});

  final String title;
  final Filter filter;
  final Filter currentFilter;
  final void Function(Filter) callback;

  BoxDecoration getDecoration(BuildContext context, bool isSelected) {
    if (isSelected) {
      return BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20));
    }
    return BoxDecoration(
        color: greyColor, borderRadius: BorderRadius.circular(20));
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = filter == currentFilter;
    Color color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).canvasColor;

    BoxDecoration decoration = getDecoration(context, isSelected);

    return GestureDetector(
        onTap: () {
          callback(filter);
        },
        child: Container(
            width: 72,
            height: 22,
            decoration: decoration,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                  height: 1),
            ))));
  }
}
