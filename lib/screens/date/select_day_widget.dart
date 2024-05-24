import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class SelectDayWidget extends StatefulWidget {
  const SelectDayWidget({super.key});

  @override
  State<SelectDayWidget> createState() => _SelectDayWidgetState();
}

class _SelectDayWidgetState extends State<SelectDayWidget> {
  List<int> _getDaysInMonth() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List<int>.generate(daysInMonth, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    int selectedDay = context.watch<DateModel>().day;

    final daysInMonth = _getDaysInMonth();

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: daysInMonth.length,
      itemBuilder: (context, index) {
        // TODO: зробити числа які менші за тепершню дату сірі та не активні
        return DaysGridRectangleWidget(
            daysInMonth: daysInMonth, selectedDay: selectedDay, index: index);
      },
    );
  }
}

class DaysGridRectangleWidget extends StatelessWidget {
  const DaysGridRectangleWidget(
      {super.key,
      required this.daysInMonth,
      required this.selectedDay,
      required this.index});

  final Color dayColor = const Color.fromARGB(255, 65, 64, 64);

  final List<int> daysInMonth;
  final int selectedDay;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<DateModel>(context, listen: false)
          .changeDay(daysInMonth[index]),
      child: Ink(
        decoration: BoxDecoration(
          color: daysInMonth[index] == selectedDay
              ? Colors.blueAccent[400]
              : Colors.white54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            daysInMonth[index].toString(),
            style: TextStyle(
                color:
                    daysInMonth[index] == selectedDay ? Colors.white : dayColor,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
