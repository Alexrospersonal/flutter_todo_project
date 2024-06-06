import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final List<Widget> dateElements = const [
    Placeholder(),
    TimePickerWidget(),
    Placeholder(),
    Placeholder(),
    Placeholder()
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog.fullscreen(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
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
                    const TaskFormTitleWidget(),
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

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  bool fromAllDay = false;
  bool twelveHourFormat = false;

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
            const Flexible(
              flex: 3,
              child: NumberInput(name: "Години")
            ),
            const Flexible(
              flex: 0,
              child: DoubleDotTimeDivider()
              ),
            const Flexible(
              flex: 3,
              child: NumberInput(name: "Хвилини")
            ),
            twelveHourFormat ? Flexible(
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
                twelveHourFormat = !twelveHourFormat;
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
              }),
            ),
            Text(
              "Протягом дня",
              style: TextStyle(
                fontSize: 16,
                height: 1,
                color: fromAllDay ? Colors.black : Colors.grey
              )
            )
          ],
        ),
        // Row with cancel and comfirm buttons
        const Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(buttonName: "Відхилити", buttonColor: Colors.grey),
            SizedBox(width: 20),
            TextButtonWidget(buttonName: "Підтвердити", buttonColor: Colors.black),
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
      selectedBorderColor: const Color.fromRGBO(118, 253, 172, 1),
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      children: const [
        SizedBox(
          width: 60,
          height: 20,
          child: Center(
            child: Text(
              "AM",
              style: TextStyle(
                fontSize: 20
              ),
              )
          ),
        ),
        SizedBox(
          width: 60,
          height: 20,
          child: Center(
            child: Text(
              "PM",
              style: TextStyle(
                fontSize: 20
              ),
            )
          ),
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

  const NumberInput({super.key, required this.name});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
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
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 2,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
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

  const TextButtonWidget({
    super.key,
    required this.buttonName,
    required this.buttonColor
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("---Tapped");
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