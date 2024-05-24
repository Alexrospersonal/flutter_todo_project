import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class SelectMonthWidget extends StatefulWidget {
  const SelectMonthWidget({super.key});

  @override
  State<SelectMonthWidget> createState() => _SelectMonthWidgetState();
}

class _SelectMonthWidgetState extends State<SelectMonthWidget> {
  @override
  Widget build(BuildContext context) {
    int currentMonth = context.watch<DateModel>().month;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: months.length,
      itemBuilder: (context, index) {
        return MonthGridRectangleWidget(
            index: index, selectedMonth: currentMonth);
      },
    );
  }
}

class MonthGridRectangleWidget extends StatelessWidget {
  const MonthGridRectangleWidget(
      {super.key, required this.selectedMonth, required this.index});

  final Color dayColor = const Color.fromARGB(255, 65, 64, 64);

  final int selectedMonth;
  final int index;

  @override
  Widget build(BuildContext context) {
    int month = index + 1;

    return InkWell(
      onTap: () =>
          Provider.of<DateModel>(context, listen: false).changeMonth(month),
      child: Ink(
        decoration: BoxDecoration(
          color:
              month == selectedMonth ? Colors.blueAccent[400] : Colors.white54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            months[index],
            style: TextStyle(
                color: month == selectedMonth ? Colors.white : dayColor,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
