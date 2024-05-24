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
    final daysInMonth =
        Provider.of<DateModel>(context, listen: false).getDaysInMonth();

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
  final Color deactiveBoxColor = const Color.fromARGB(255, 211, 211, 211);

  final List<int> daysInMonth;
  final int selectedDay;
  final int index;

  bool validateCreatedDate(BuildContext context) {
    var currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    var createdDate = DateTime(
        Provider.of<DateModel>(context, listen: false).year,
        Provider.of<DateModel>(context, listen: false).month,
        daysInMonth[index]);

    if (createdDate.isBefore(currentDate)) {
      return true;
    }

    return false;
  }

  Color getTextColor(BuildContext context) {
    if (validateCreatedDate(context)) {
      return Colors.white;
    }

    return daysInMonth[index] == selectedDay ? Colors.white : dayColor;
  }

  Color getBoxColor(BuildContext context) {
    if (validateCreatedDate(context)) {
      return deactiveBoxColor;
    }

    return daysInMonth[index] == selectedDay
        ? Colors.blueAccent
        : Colors.white54;
  }

  void changeDay(BuildContext context) {
    if (validateCreatedDate(context) == false) {
      Provider.of<DateModel>(context, listen: false)
          .changeDay(daysInMonth[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => changeDay(context),
      child: Ink(
        decoration: BoxDecoration(
          color: getBoxColor(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            daysInMonth[index].toString(),
            style: TextStyle(color: getTextColor(context), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
