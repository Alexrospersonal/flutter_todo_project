import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:flutter_todo_project/settings.dart';

class TasksCategoryFilters extends StatefulWidget {
  const TasksCategoryFilters({super.key});

  @override
  State<TasksCategoryFilters> createState() => _TasksCategoryFiltersState();
}

class _TasksCategoryFiltersState extends State<TasksCategoryFilters> {

  Filter currentFilter = Filter.newest;

  void setFilter(Filter filter) {
    setState(() {
      currentFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  const TaskCategoryFiltersItem({
    super.key,
    required this.title,
    required this.filter,
    required this.currentFilter,
    required this.callback
  });

  final String title;
  final Filter filter;
  final Filter currentFilter;
  final void Function(Filter) callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(filter);
      },
      child: filter == currentFilter ? TaskFiltersItemEnabledContainer(title: title,) : TaskFiltersItemDisabledContainer(filter: filter,),
    );
  }
}

class TaskFiltersItemEnabledContainer extends StatelessWidget {
  const TaskFiltersItemEnabledContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 22,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
            height: 1
          ),
        )
      )
    );
  }
}

class TaskFiltersItemDisabledContainer extends StatelessWidget {
  const TaskFiltersItemDisabledContainer({
    super.key,
    required this.filter,
  });

  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 22,
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Text(
          filter.name,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).canvasColor,
            fontWeight: FontWeight.w500,
            height: 1
          ),
        )
      )
    );
  }
}