import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/date_selector_info_widget.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/day_in_week_widget/days_in_week_picker_widget.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_date_selector_widget.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/task_duration_picker_widget.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/time_picker_widget/time_picker_widget.dart';

class DateSettingsWidget extends StatefulWidget {
  const DateSettingsWidget({super.key});

  @override
  State<DateSettingsWidget> createState() => _DateSettingsWidgetSatte();
}

class _DateSettingsWidgetSatte extends State<DateSettingsWidget> {

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    // _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size displaySize = MediaQuery.of(context).size;
    double width = displaySize.width * 0.9;
    double height = displaySize.height * 0.43;
    List<Map<String, IconData>> selectorButtonsNames = [
      {"Опис": Icons.list},
      {"Час": Icons.timer_outlined},
      {"Повтор": Icons.edit_calendar_rounded},
      {"Тривалість": Icons.timelapse_rounded},
      {"Нагадування": Icons.notification_add_rounded},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(selectorButtonsNames.length, (index) => DateSelectorButton(
            icon: selectorButtonsNames[index].entries.first.value,
            index: index,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            buttonName: selectorButtonsNames[index].entries.first.key
          )).toList(),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: width,
          height: height,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: const [
              DateSelectorInfoWidget(),
              TaskTimePickerWidget(),
              DaysInWeekPickerWidget(),
              TaskDurationPickerWidget(),
              NotificationSelectorWidget()
            ],
          ),
        )
      ],
    );
  } 
}

class DateSelectorButton extends StatelessWidget {

  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String buttonName;
  
  
  const DateSelectorButton({
      super.key,
      required this.icon,
      required this.index,
      required this.selectedIndex,
      required this.onItemTapped,
      required this.buttonName
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        constraints: const BoxConstraints(
          minWidth: 40,
          maxWidth: 120
        ),
        alignment: Alignment.center,
        width: index == selectedIndex ? 120 : 40,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal:8),
        decoration: BoxDecoration(
          color: index == selectedIndex ?
            const Color.fromRGBO(118, 253, 172, 1) :
              const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Icon(icon),
            if (index == selectedIndex)
              Expanded(
                child: Text(
                  buttonName, // Use your buttonName variable here
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        )
      ),
    );
  }
}