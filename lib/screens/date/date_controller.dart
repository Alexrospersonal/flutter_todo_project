import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  bool _isGridViewVisible = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DateModel(),
      child: Column(children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isGridViewVisible = !_isGridViewVisible;
                  });
                },
                child: Text(_isGridViewVisible ? 'Hide date' : 'Show date')),
            const SizedBox(width: 20),
            Consumer<DateModel>(
              builder: (context, date, child) {
                return _isGridViewVisible
                    ? const SizedBox()
                    : Text('Date: ${date.day}/${date.month}/${date.year}');
              },
            ),
          ],
        ),
        if (_isGridViewVisible) const DateSelectorWidget()
      ]),
    );
  }
}

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({super.key});

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  // int day = Provider.of<DateModel>(context, listen: false).changeDay(date);
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  bool _isDayViewVisible = false;
  bool _isMonthViewVisible = false;
  bool _isYearViewVisible = false;

  @override
  void initState() {
    super.initState();
    day = Provider.of<DateModel>(context, listen: false).day;
    month = Provider.of<DateModel>(context, listen: false).month;
    year = Provider.of<DateModel>(context, listen: false).year;
  }

  void changeButtonDay(int newDay) {
    setState(() {
      day = Provider.of<DateModel>(context, listen: false).day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDayViewVisible = !_isDayViewVisible;
                    _isMonthViewVisible = false;
                    _isYearViewVisible = false;
                  });
                },
                child: Text('Day: $day')),
            ElevatedButton(onPressed: () {}, child: Text('Month: $month')),
            ElevatedButton(onPressed: () {}, child: Text('Year: $year')),
          ],
        ),
        if (_isDayViewVisible) SelectDayWidget(changeDay: changeButtonDay)
      ],
    );
  }
}

class SelectDayWidget extends StatefulWidget {
  final void Function(int) changeDay;

  const SelectDayWidget({super.key, required this.changeDay});

  @override
  State<SelectDayWidget> createState() => _SelectDayWidgetState();
}

class _SelectDayWidgetState extends State<SelectDayWidget> {
  int today = DateTime.now().day;

  List<int> _getDaysInMonth() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List<int>.generate(daysInMonth, (index) => index + 1);
  }

  void _changeDay(int date) {
    Provider.of<DateModel>(context, listen: false).changeDay(date);
    setState(() {
      today = date;
    });
    widget.changeDay(date);
  }

  @override
  Widget build(BuildContext context) {
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
        return InkWell(
          onTap: () => _changeDay(daysInMonth[index]),
          child: Ink(
            decoration: BoxDecoration(
              color: daysInMonth[index] == today
                  ? Colors.blueAccent[400]
                  : Colors.white54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                daysInMonth[index].toString(),
                style: TextStyle(
                    color: daysInMonth[index] == today
                        ? Colors.white
                        : const Color.fromARGB(255, 65, 64, 64),
                    fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
