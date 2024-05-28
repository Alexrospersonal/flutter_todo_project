import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:flutter_todo_project/screens/date/date_selector_widget.dart';
import 'package:flutter_todo_project/screens/time_selector/time_selector_widget.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isDateViewVisible = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isTimeViewVisible = ValueNotifier<bool>(false);

    return ChangeNotifierProvider(
      create: (context) => DateModel(),
      child: Column(children: [
        // Date button and info field
        Row(
          children: [
            DateOpenButtonWidget(
                isGridViewVisible: isDateViewVisible, buttonName: 'date'),
            const SizedBox(width: 20),
            DateTextLabelWidget(isGridViewVisible: isDateViewVisible),
          ],
        ),
        // Date selector widget
        ValueListenableBuilder<bool>(
          valueListenable: isDateViewVisible,
          builder: (context, value, child) {
            return value ? const DateSelectorWidget() : const SizedBox.shrink();
          },
        ),
        // Time selector widget
        Row(
          children: [
            const TimeSelectorWidget(),
            const SizedBox(width: 20),
            DateTextLabelWidget(
                isGridViewVisible: isTimeViewVisible, time: true),
          ],
        ),
      ]),
    );
  }
}

class DateOpenButtonWidget extends StatelessWidget {
  const DateOpenButtonWidget(
      {super.key, required this.isGridViewVisible, required this.buttonName});

  final ValueNotifier<bool> isGridViewVisible;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          isGridViewVisible.value = !isGridViewVisible.value;
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: isGridViewVisible,
          builder: (context, value, child) => Text(isGridViewVisible.value
              ? 'Hide $buttonName'
              : 'Show $buttonName'),
        ));
  }
}

class DateTextLabelWidget extends StatelessWidget {
  const DateTextLabelWidget(
      {super.key, required this.isGridViewVisible, this.time = false});

  final ValueNotifier<bool> isGridViewVisible;
  final bool time;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isGridViewVisible,
        builder: (context, value, child) {
          return Consumer<DateModel>(
            builder: (context, date, child) {
              return isGridViewVisible.value
                  ? const SizedBox.shrink()
                  : Text(time
                      ? date.getFormatedTimeAsString()
                      : date.getFormatedDateAsString());
            },
          );
        });
  }
}
