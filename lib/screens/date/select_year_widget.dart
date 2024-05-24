import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class SelectYearWidget extends StatefulWidget {
  const SelectYearWidget({super.key});

  @override
  State<SelectYearWidget> createState() => _SelectYearWidgetState();
}

class _SelectYearWidgetState extends State<SelectYearWidget> {
  @override
  Widget build(BuildContext context) {
    int selectedYear = context.watch<DateModel>().year;

    final years = context.watch<DateModel>().getYearsList();

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
      itemCount: years.length,
      itemBuilder: (context, index) {
        // TODO: зробити числа які менші за тепершню дату сірі та не активні
        return YearsGridRectangleWidget(
            years: years, selectedYear: selectedYear, index: index);
      },
    );
  }
}

class YearsGridRectangleWidget extends StatelessWidget {
  const YearsGridRectangleWidget(
      {super.key,
      required this.years,
      required this.selectedYear,
      required this.index});

  final Color dayColor = const Color.fromARGB(255, 65, 64, 64);

  final List<int> years;
  final int selectedYear;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<DateModel>(context, listen: false)
          .changeYear(years[index]),
      child: Ink(
        decoration: BoxDecoration(
          color: years[index] == selectedYear
              ? Colors.blueAccent[400]
              : Colors.white54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            years[index].toString(),
            style: TextStyle(
                color: years[index] == selectedYear ? Colors.white : dayColor,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
