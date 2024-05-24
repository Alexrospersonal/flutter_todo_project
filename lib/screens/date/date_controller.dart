import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:flutter_todo_project/screens/date/date_selector_widget.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isGridViewVisible = ValueNotifier<bool>(false);

    return ChangeNotifierProvider(
      create: (context) => DateModel(),
      child: Column(children: [
        Row(
          children: [
            DateOpenButtonWidget(isGridViewVisible: isGridViewVisible),
            const SizedBox(width: 20),
            DateTextLabelWidget(isGridViewVisible: isGridViewVisible),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isGridViewVisible,
          builder: (context, value, child) {
            return value ? const DateSelectorWidget() : const SizedBox.shrink();
          },
        )
      ]),
    );
  }
}

class DateOpenButtonWidget extends StatelessWidget {
  const DateOpenButtonWidget({
    super.key,
    required this.isGridViewVisible,
  });

  final ValueNotifier<bool> isGridViewVisible;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          isGridViewVisible.value = !isGridViewVisible.value;
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: isGridViewVisible,
          builder: (context, value, child) =>
              Text(isGridViewVisible.value ? 'Hide date' : 'Show date'),
        ));
  }
}

class DateTextLabelWidget extends StatelessWidget {
  const DateTextLabelWidget({
    super.key,
    required this.isGridViewVisible,
  });

  final ValueNotifier<bool> isGridViewVisible;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isGridViewVisible,
        builder: (context, value, child) {
          return Consumer<DateModel>(
            builder: (context, date, child) {
              return isGridViewVisible.value
                  ? const SizedBox.shrink()
                  : Text(date.getFormatedDateAsString());
            },
          );
        });
  }
}
