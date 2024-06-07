import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({super.key});

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  int _selectedIndex = 0;

    final List<Widget> dateElements = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void backToMain() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final List<Widget> dateElements = [
      const Placeholder(),
      TimePickerWidget(backToMain: backToMain),
      DaysInWeekPickerWidget(backToMain: backToMain),
      const Placeholder(),
      const Placeholder()
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog.fullscreen(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        backgroundColor: Colors.transparent,
        // shadowColor: Colors.black,
        // insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TaskFormTitleWidget(title: "обрати дату",),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      height: 295,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: const CalendarWidget(),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // direction: Axis.horizontal,
                      children: [
                        DateSelectorButton(
                          icon: Icons.list,
                          index: 0,
                          selectedIndex: _selectedIndex,
                          onItemTapped: _onItemTapped,
                        ),
                        DateSelectorButton(
                          icon: Icons.timer_outlined,
                          index: 1,
                          selectedIndex: _selectedIndex,
                          onItemTapped: _onItemTapped,
                        ),
                        DateSelectorButton(
                          icon: Icons.edit_calendar_rounded,
                          index: 2,
                          selectedIndex: _selectedIndex,
                          onItemTapped: _onItemTapped,
                        ),
                        DateSelectorButton(
                          icon: Icons.timelapse_rounded,
                          index: 3,
                          selectedIndex: _selectedIndex,
                          onItemTapped: _onItemTapped,
                        ),
                        DateSelectorButton(
                          icon: Icons.notification_add_rounded,
                          index: 4,
                          selectedIndex: _selectedIndex,
                          onItemTapped: _onItemTapped,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      height: 240,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: dateElements[_selectedIndex],
                    ),
                    const SizedBox(height: 8),
                    DoneDateButton(action: () {})
                  ]
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}

class DaysInWeekPickerWidget extends StatefulWidget {
  final Function backToMain;

  const DaysInWeekPickerWidget({
    super.key,
    required this.backToMain
  });

  @override
  State<DaysInWeekPickerWidget> createState() => _DaysInWeekPickerWidgetState();
}

class _DaysInWeekPickerWidgetState extends State<DaysInWeekPickerWidget> {
  final List<bool> _selectedDays = List.generate(7, (index) => false);

  final List<String> _weekDays = ['Пн','Вт','Ср','Чт','Пт','Сб','Нд',];

  bool _isEndless = true;

  DateTime dateOfTheEnd = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 1);

  String dateOfTheEndText = "Без кінця";

  void changeDateOfEnd(DateTime date) {
    setState(() {
      dateOfTheEnd = date;
      dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text("Виберіть дні повторення завдання",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row with days
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _weekDays.length,
            (index) {
              return DayInWeekLableWidget(dayName: _weekDays[index], index: index, selectedDays: _selectedDays,);
            }
          )           // DayInWeekLableWidget(dayName: "Пн",)
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Switch(
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              value: !_isEndless,
              onChanged:(value) => setState(() {
                _isEndless = !_isEndless;
                if (_isEndless == false) {
                  dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
                } else {
                  dateOfTheEndText = "Без кінця";
                }
              }),
            ),
            // const SizedBox(width: 5),
            const Text("Закінчення повтору",
              style: TextStyle(
                fontSize: 16,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(width: 40),
            GestureDetector(
              onTap: () {
                if (_isEndless == false) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: Colors.white.withOpacity(0.5),
                    builder:(context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: SimpleDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const TaskFormTitleWidget(title: "Дата завершення"),
                                        SizedBox(
                                          width: 400,
                                          height: 300,
                                          child: Center(
                                            child: CalendarWidget(changeDate: changeDateOfEnd,)
                                          ),
                                        )
                                        // CalendarWidget()
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 155-30,
                                    right: 155-30,
                                    bottom: -25,
                                    child: DoneButton(action: () {},)
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: _isEndless ? 
                    const Color.fromARGB(255, 231, 231, 231) :
                      const Color.fromRGBO(118, 253, 172, 1),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(
                  child: Text(dateOfTheEndText),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(buttonName: "Відхилити", buttonColor: Colors.grey, backToMain: widget.backToMain),
            const SizedBox(width: 20),
            TextButtonWidget(buttonName: "Підтвердити", buttonColor: Colors.black, backToMain: widget.backToMain),
          ]
        )
      ]
    );
  }

}

class DayInWeekLableWidget extends StatefulWidget {
  
  final String dayName;
  final int index;
  final List<bool> selectedDays;

  const DayInWeekLableWidget({
    super.key,
    required this.dayName,
    required this.index,
    required this.selectedDays
  });

    @override
  State<DayInWeekLableWidget> createState() => _DayInWeekLableWidgetState();
}

class _DayInWeekLableWidgetState extends State<DayInWeekLableWidget> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.selectedDays[widget.index] = !widget.selectedDays[widget.index];
          });
        },
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 90,
            maxWidth: 47
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 231, 231, 231),
              width: 2
            ),
            color: widget.selectedDays[widget.index] ?
              const Color.fromRGBO(118, 253, 172, 1) :
                const Color.fromARGB(255, 241, 241, 241)
          ),
          child:Center(
            child: Text(
              widget.dayName,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimePickerWidget extends StatefulWidget {

  final Function backToMain;

  const TimePickerWidget({
    super.key,
    required this.backToMain
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  bool fromAllDay = false;
  bool twelveHourFormat = false;
  int hourFormat = 24;
  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text("Введіть час",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // Row with time picker
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hours
            Flexible(
              flex: 3,
              child: NumberInput(name: "Години", maxValue: hourFormat,controller: hoursController,enabled: !fromAllDay,)
            ),
            const Flexible(
              flex: 0,
              child: DoubleDotTimeDivider()
              ),
            Flexible(
              flex: 3,
              child: NumberInput(name: "Хвилини", maxValue: 60,controller: minutesController,enabled: !fromAllDay)
            ),
            twelveHourFormat ? const Flexible(
              flex: 2,
              child: AmPmToggleContainer(),
            ) : const SizedBox.shrink()
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Switch(
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              value: twelveHourFormat,
              onChanged:(value) => setState(() {
                hourFormat = hourFormat == 24 ? 13: 24;
                if (fromAllDay == false) {
                  twelveHourFormat = !twelveHourFormat;
                }
                hoursController.clear();
              }),
            ),
            Text(
              "AM/PM",
              style: TextStyle(
                fontSize: 16,
                height: 1,
                color: fromAllDay ? Colors.black : Colors.grey
              )
            ),
            const SizedBox(width: 30),
            // From day setting button
            Switch(
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              value: fromAllDay,
              onChanged:(value) => setState(() {
                fromAllDay = !fromAllDay;
                if (fromAllDay) {
                  hoursController.clear();
                  minutesController.clear();
                  twelveHourFormat = false;
                }
              }),
            ),
            Text(
              "Без часу",
              style: TextStyle(
                fontSize: 16,
                height: 1,
                color: fromAllDay ? Colors.black : Colors.grey
              )
            )
          ],
        ),
        // Row with cancel and comfirm buttons
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(buttonName: "Відхилити", buttonColor: Colors.grey, backToMain: widget.backToMain),
            const SizedBox(width: 20),
            TextButtonWidget(buttonName: "Підтвердити", buttonColor: Colors.black, backToMain: widget.backToMain),
          ],
        )
      ],
    );
  }
}

class AmPmToggleContainer extends StatefulWidget {
  const AmPmToggleContainer({
    super.key,
  });

  @override
  State<AmPmToggleContainer> createState() => _AmPmToggleContainerState();
}

class _AmPmToggleContainerState extends State<AmPmToggleContainer> {
  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.vertical,
      fillColor: const Color.fromRGBO(118, 253, 172, 1),
      selectedBorderColor: const Color.fromRGBO(118, 253, 172, 1),
      selectedColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      constraints: const BoxConstraints(
        maxHeight: 43
      ),
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      children: const [
        Center(
          child: Text(
            "AM",
            style: TextStyle(
              fontSize: 18
            ),
            )
        ),
        Center(
          child: Text(
            "PM",
            style: TextStyle(
              fontSize: 18
            ),
          )
        ),
      ],
    );
  }
}

class DoubleDotTimeDivider extends StatelessWidget {
  const DoubleDotTimeDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      ":",
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.bold,
        height: 1
      ),
    );
  }
}

class NumberInput extends StatefulWidget {
  final String name;
  final int maxValue;
  final TextEditingController controller;
  final bool enabled;

  const NumberInput({
    super.key,
    required this.name,
    required this.maxValue,
    required this.controller,
    required this.enabled
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 85,
          constraints: const BoxConstraints(
            maxWidth: 160,
            minWidth: 90
          ),
          // alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 228, 228),
            borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            enabled: widget.enabled,
            maxLength: 2,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                final enteredNumber = int.tryParse(newValue.text);
                if (enteredNumber != null && enteredNumber >= widget.maxValue) {
                  return const TextEditingValue(text: '00', selection: TextSelection.collapsed(offset: 2));
                }
                return newValue;
              }),
            ],
            cursorHeight: 60,
            cursorWidth: 2,
            cursorColor: const Color.fromRGBO(118, 253, 172, 1),
            decoration: const InputDecoration(
              border: InputBorder.none,
              label: null,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 15)
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
              height: 1
            ),
          ),
        ),
        const SizedBox(height: 3),
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 15
            ),
        )
      ],
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Function backToMain;

  const TextButtonWidget({
    super.key,
    required this.buttonName,
    required this.buttonColor,
    required this.backToMain
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        backToMain();
      },
      child: Container(
        height: 25,
        alignment: Alignment.center,
        // color: Colors.amber,
        child: Text(
            buttonName,
            style: TextStyle(
              height: 1.4,
              fontSize: 14,
              color: buttonColor
            ),
          ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return TextButton(
  //     style:const ButtonStyle(
  //       padding: MaterialStatePropertyAll(EdgeInsets.zero)
  //     ),
  //     onPressed: () {},
  //     child: Text(
  //         buttonName,
  //         style: TextStyle(
  //           // height: 1,
  //           fontSize: 14,
  //           color: buttonColor
  //         ),
  //       )
  //     );
  // }
}


class DoneDateButton extends StatelessWidget {
  final Function action;

  const DoneDateButton({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity, // Зайняти всю ширину колонки
      child: IconButton.filled(
        onPressed: () {
          action();
          Navigator.of(context).pop();
        },
        padding: const EdgeInsets.all(0),
        color: const Color.fromARGB(255, 31, 31, 31),
        iconSize: 36.0,
        icon: const Icon(Icons.done),
        style: IconButton.styleFrom(
          backgroundColor: const Color.fromRGBO(118, 253, 172, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}

class DateSelectorButton extends StatelessWidget {

  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;
  
  const DateSelectorButton({
      super.key,
      required this.icon,
      required this.index,
      required this.selectedIndex,
      required this.onItemTapped
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onItemTapped(index),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 20)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(
            index == selectedIndex ? const Color.fromRGBO(118, 253, 172, 1) : Colors.white
            ),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Icon(icon)
    );
  }
}