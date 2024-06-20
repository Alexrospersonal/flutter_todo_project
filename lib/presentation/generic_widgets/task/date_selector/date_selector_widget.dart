import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:flutter_todo_project/presentation/screens/calendar_screen/calendar_widget.dart';


class DateSelectorWidget2 extends StatefulWidget {
  const DateSelectorWidget2({super.key});

  @override
  State<DateSelectorWidget2> createState() => _DateSelectorWidget2State();
}

// TODO: розробити розрахунки розмірів.
class _DateSelectorWidget2State extends State<DateSelectorWidget2> {
  bool isFirstLarge = true;
  Duration animDuration = const Duration(milliseconds: 100);

  double minHeight = 0.25;
  double maxHeight = 0.60 - 0.01;
  double titleHeight = 0.07;
  double doneButtonHeight = 0.07;

  double padding = 8.0;

  void _toggleSizes(bool res) {
    setState(() {
      isFirstLarge = res;
    });
  }

  void _swipeToggleHandler(DragUpdateDetails details) {
    if (details.primaryDelta! < -10) {
      // print("Swipe Up");
      if (isFirstLarge) {
        _toggleSizes(false);
      }
    }
    else if (details.primaryDelta! > 10) {
      // print("Swipe Down");
      if (!isFirstLarge) {
        _toggleSizes(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - padding * 4;
    double paddingHeight = screenHeight * 0.01;

    double maxSize = screenHeight * maxHeight;
    double minSize = screenHeight * minHeight;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg1.jpg'),
            fit: BoxFit.cover,
            opacity: 0.75,
          ),
          color: Colors.black
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GestureDetector(
            onVerticalDragUpdate: _swipeToggleHandler,
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, padding * 3, padding, 0),
              child: Column(
                children: <Widget>[
                  DateTitleCardWidget(
                    screenHeight: screenHeight,
                    titleHeight: titleHeight,
                    child: const TaskFormTitleWidget(title: "дата та час"),
                  ),
                  DateSelectorCardWidget(
                    minSize: minSize,
                    maxSize: maxSize,
                    isFirstLarge: isFirstLarge,
                    toggleSizes: _toggleSizes,
                    isTop: true,
                    child: const CalendarCardWidget(),
                  ),
                  SizedBox(height: paddingHeight),
                  DateSelectorCardWidget(
                    minSize: minSize,
                    maxSize: maxSize,
                    isFirstLarge: !isFirstLarge,
                    toggleSizes: _toggleSizes,
                    isTop: false,
                    child: const DateSettingsWidget()
                  ),
                  SizedBox(height: paddingHeight),
                  DateDoneButtonCardWidget(
                    screenHeight: screenHeight,
                    doneButtonHeight: doneButtonHeight,
                    child: DoneDateButton(action: () {}),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } 
}

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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            DateSelectorButton(
              icon: Icons.list,
              index: 0,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              buttonName: "Опис",
            ),
            const SizedBox(width: 3),
            DateSelectorButton(
              icon: Icons.timer_outlined,
              index: 1,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              buttonName: "Час",
            ),
            const SizedBox(width: 3),
            DateSelectorButton(
              icon: Icons.edit_calendar_rounded,
              index: 2,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              buttonName: "Повтор",
            ),
            const SizedBox(width: 3),
            DateSelectorButton(
              icon: Icons.timelapse_rounded,
              index: 3,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              buttonName: "Тривалість",
            ),
            const SizedBox(width: 3),
            DateSelectorButton(
              icon: Icons.notification_add_rounded,
              index: 4,
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              buttonName: "Нагадування",
            ),
          ],
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
            children: [
              const DateSelectorListInfoWidget(),
              const TimePickerWidget(),
              const DaysInWeekPickerWidget(),
              TaskDurationPickerWidget(backToMain: () {}),
              NotificationSelectorWidget(backToMain: () {})
            ],
          ),
        )
      ],
    );
  } 
}

class DateDoneButtonCardWidget extends StatelessWidget {
  const DateDoneButtonCardWidget({
    super.key,
    required this.screenHeight,
    required this.doneButtonHeight,
    required this.child
  });

  final double screenHeight;
  final double doneButtonHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: screenHeight * doneButtonHeight,
        color: Colors.transparent,
        child: child
      ),
    );
  }
}

class DateTitleCardWidget extends StatelessWidget {
  const DateTitleCardWidget({
    super.key,
    required this.screenHeight,
    required this.titleHeight,
    required this.child
  });

  final Widget child;
  final double screenHeight;
  final double titleHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * titleHeight,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: child,
    );
  }
}

class DateSelectorCardWidget extends StatelessWidget {
  final double minSize;
  final double maxSize;
  final bool isFirstLarge;
  final void Function(bool) toggleSizes;
  final bool isTop;
  final Widget child;

  const DateSelectorCardWidget({
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.isFirstLarge,
    required this.toggleSizes,
    required this.isTop,
    required this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleSizes(isTop);
      },
      child: Opacity(
        opacity: isFirstLarge == false ? 0.35 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.75),
          ),
          height: isFirstLarge ? maxSize : minSize,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IgnorePointer(
              ignoring: isFirstLarge == true ? false : true,
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          )
        ),
      ),
    );
  }
}

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CalendarWidget()
      ],
    );
  }
}






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
      const DateSelectorListInfoWidget(),
      const TimePickerWidget(),
      const DaysInWeekPickerWidget(),
      TaskDurationPickerWidget(backToMain: backToMain),
      NotificationSelectorWidget(backToMain: backToMain)
    ];

    return const Dialog.fullscreen(
      backgroundColor:Color.fromARGB(0, 0, 0, 0),
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child:  SafeArea(child: AnimatedWidget())
      ),
    );

  //   return GestureDetector(
  //     onTap: () => FocusScope.of(context).unfocus(),
  //     child: Dialog.fullscreen(
  //       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
  //       backgroundColor: const Color.fromARGB(0, 0, 0, 0),
  //       // shadowColor: Colors.black,
  //       // insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const TaskFormTitleWidget(title: "обрати дату",),
  //                   Container(
  //                     alignment: Alignment.center,
  //                     height: 295,
  //                     width: 450,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(15)
  //                     ),
  //                     child: const CalendarWidget(),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Row(
  //                     mainAxisSize: MainAxisSize.max,
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     // direction: Axis.horizontal,
  //                     children: [
  //                       DateSelectorButton(
  //                         icon: Icons.list,
  //                         index: 0,
  //                         selectedIndex: _selectedIndex,
  //                         onItemTapped: _onItemTapped,
  //                       ),
  //                       DateSelectorButton(
  //                         icon: Icons.timer_outlined,
  //                         index: 1,
  //                         selectedIndex: _selectedIndex,
  //                         onItemTapped: _onItemTapped,
  //                       ),
  //                       DateSelectorButton(
  //                         icon: Icons.edit_calendar_rounded,
  //                         index: 2,
  //                         selectedIndex: _selectedIndex,
  //                         onItemTapped: _onItemTapped,
  //                       ),
  //                       DateSelectorButton(
  //                         icon: Icons.timelapse_rounded,
  //                         index: 3,
  //                         selectedIndex: _selectedIndex,
  //                         onItemTapped: _onItemTapped,
  //                       ),
  //                       DateSelectorButton(
  //                         icon: Icons.notification_add_rounded,
  //                         index: 4,
  //                         selectedIndex: _selectedIndex,
  //                         onItemTapped: _onItemTapped,
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Container(
  //                     padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
  //                     alignment: Alignment.center,
  //                     height: 240,
  //                     width: 450,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(15)
  //                     ),
  //                     child: dateElements[_selectedIndex],
  //                   ),
  //                   const SizedBox(height: 8),
  //                   DoneDateButton(action: () {})
  //                 ]
  //               )
  //             ),
  //           ],
  //         ),
  //       ),
  //     )
  //   );
  }
}

class AnimatedWidget extends StatefulWidget {
  const AnimatedWidget({super.key});

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget> {
  Duration duration = const Duration(milliseconds: 100);
  int _flex1 = 6, _flex2 = 1, _flex3 = 4, _flex4 = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 40;

    var height1 = (_flex1 * height) / (_flex1 + _flex2 + _flex3 + _flex4);
    var height2 = (_flex2 * height) / (_flex1 + _flex2 + _flex3 + _flex4);
    var height3 = (_flex3 * height) / (_flex1 + _flex2 + _flex3 + _flex4);
    var height4 = (_flex4 * height) / (_flex1 + _flex2 + _flex3 + _flex4);

    print("Height: ${height1 + height2 + height3 + height4}");

    return Column(
          children: [
            GestureDetector(
              onTap: () =>  setState(() {
                _flex1 = 6;
                _flex3 = 4;
              }),
              child: AnimatedContainer(
                duration: duration,
                height: height1,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),
            // const SizedBox(height: 5),
            AnimatedContainer(
              height: height2,
              duration: duration,
              color: Colors.blue,
            ),
            // const SizedBox(height: 5),
            GestureDetector(
              onTap: () =>  setState(() {
                _flex1 = 4;
                _flex3 = 6;
              }),
              child: AnimatedContainer(
                height: height3,
                duration: duration,
                child: Container(
                  color: Colors.yellow,
                ),
              ),
            ),
            // const SizedBox(height: 5),
            AnimatedContainer(
              height: height4,
              duration: duration,
              color: Colors.blue,
            ),
          ]
    );
  }
}




class NotificationSelectorWidget extends StatefulWidget {
  final Function backToMain;

  const NotificationSelectorWidget({
    super.key,
    required this.backToMain
  });

  @override
  State<NotificationSelectorWidget> createState() => _NotificationSelectorWidget();
}

class _NotificationSelectorWidget extends State<NotificationSelectorWidget> {

  String firstNotificationText = "Додати";
  IconData firstNotificationIcon = Icons.notification_add;
  List<bool> notificationButtonsState = [false, false, false];

  @override
  Widget build(Object context) {
    return Column(
      children: [
        // Title
        Row(
          children: [
            Text("Створіть нагадування",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Row with add and delete buttons and text
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    notificationButtonsState[0] = !notificationButtonsState[0];

                    setState(() {
                      if (notificationButtonsState[0] == false) {
                        firstNotificationText = "Додати";
                        firstNotificationIcon = Icons.notification_add;
                      } else {
                        firstNotificationText = "Змінити";
                        firstNotificationIcon = Icons.edit_notifications;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: !notificationButtonsState[0] ? 
                        const Color.fromARGB(255, 231, 231, 231) :
                          const Color.fromRGBO(118, 253, 172, 1),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(firstNotificationIcon),
                          const SizedBox(width: 3),
                          Text(
                            firstNotificationText,
                            style: const TextStyle(
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                // Delete button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      notificationButtonsState[0] = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: !notificationButtonsState[0] ? 
                        const Color.fromARGB(255, 231, 231, 231) :
                          const Color.fromARGB(255, 253, 118, 118),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_forever_rounded,
                            color: !notificationButtonsState[0] ?
                              Color.fromARGB(255, 129, 129, 129):
                                Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 5,),
            // Row with text for notification
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      "Нагадати\nза",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        height: 1,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
                SizedBox(width: 5,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "01",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "день",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "09",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "годин",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "34",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "хвилин",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        const Divider(
              color: Color.fromRGBO(118, 253, 172, 1),
            ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(buttonName: "Відхилити", buttonColor: Colors.grey, backToMain: widget.backToMain),
            const SizedBox(width: 20),
            TextButtonWidget(buttonName: "Підтвердити", buttonColor: Colors.black, backToMain: widget.backToMain),
          ],
        ),
      ],
    );
  }
  
}

class DateSelectorListInfoWidget extends StatelessWidget {
  const DateSelectorListInfoWidget({super.key});
  
  @override
  Widget build(Object context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius:BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1
        )
      ),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            ListInfoItem(label: "Дата", text: "26/05/2025",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Година", text: "18:00",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Повторення", text: "Вт, Пт, Нд",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Тривалість", text: "4 год. 18 хв.",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Нагадати за", text: "дні: 1, год: 4, хв: 17",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  
}

class ListInfoItem extends StatelessWidget {
  final String label;
  final String text;

  const ListInfoItem({
    super.key,
    required this.label,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}

class TaskDurationPickerWidget extends StatefulWidget {
  final Function backToMain;

  const TaskDurationPickerWidget({
    super.key,
    required this.backToMain
  });

  @override
  State<TaskDurationPickerWidget> createState() => _TaskDurationPickerWidgetState();
}

class _TaskDurationPickerWidgetState extends State<TaskDurationPickerWidget> {
  bool isActive = false;
  bool notificatioOfEnd = false;
  int hourFormat = 24;

  TextEditingController hoursController = TextEditingController();
  TextEditingController minutesController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Header Row
        const Row(
          children: [
            Text("Твивалість завдання",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        // Row with switchers
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Switch(
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              value: isActive,
              onChanged:(value) => setState(() {
                isActive = !isActive;
              }),
            ),
            const SizedBox(width: 5),
            Text(
              isActive ? "Вимкнути\nтривалість" : "Увімкнути\nтривалість",
              style: const TextStyle(
                fontSize: 16,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(width: 50),
            Switch(
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              value: notificatioOfEnd,
              onChanged:(value) => setState(() {
                notificatioOfEnd = !notificatioOfEnd;
              }),
            ),
            const SizedBox(width: 5),
            const Text("Сповіщати\nпро кінець",
              style: TextStyle(
                fontSize: 16,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        // Row with times
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hours
            Flexible(
              flex: 1,
              child: NumberInput(name: "Години", maxValue: hourFormat,controller: hoursController,enabled: isActive)
            ),
            const Flexible(
              flex: 0,
              child: DoubleDotTimeDivider()
              ),
            Flexible(
              flex: 1,
              child: NumberInput(name: "Хвилини", maxValue: 60,controller: minutesController,enabled: isActive)
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Початок:\n${startDate.day}/${startDate.month}/${startDate.year} ${startDate.hour}:${startDate.minute}",
              style: const TextStyle(
                height: 1,
                fontSize: 16
              ),
            ),
            Text(
              "Кінець:\n${startDate.day}/${startDate.month}/${startDate.year} ${startDate.hour}:${startDate.minute}",
              textAlign: TextAlign.end,
              style: const TextStyle(
                height: 1,
                fontSize: 16,
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(buttonName: "Відхилити", buttonColor: Colors.grey, backToMain: widget.backToMain),
            const SizedBox(width: 20),
            TextButtonWidget(buttonName: "Підтвердити", buttonColor: Colors.black, backToMain: widget.backToMain),
          ],
        ),
      ],
    );
  }

}

class DaysInWeekPickerWidget extends StatefulWidget {
  const DaysInWeekPickerWidget({ super.key });

  @override
  State<DaysInWeekPickerWidget> createState() => _DaysInWeekPickerWidgetState();
}

class _DaysInWeekPickerWidgetState extends State<DaysInWeekPickerWidget> {
  final List<bool> selectedDays = List.generate(7, (index) => false);
  final List<String> weekDays = ['Пн','Вт','Ср','Чт','Пт','Сб','Нд',];

  bool isEndless = true;
  DateTime dateOfTheEnd = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 1);
  String dateOfTheEndText = "Без кінця";

  void changeDateOfEnd(DateTime date) {
    setState(() {
      dateOfTheEnd = date;
      dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
    });
  }

  void showEndOfRepeatDayDialog() {
    if (isEndless == false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
        builder:(context) {
          return DialogContainer(
            children: [
              InnerDialogContainer(
                title: "Дата завершення",
                child: CalendarWidget(changeDate: changeDateOfEnd)
              ),
              Positioned(
                left: 155-30,
                right: 155-30,
                bottom: -25,
                child: DoneButton(action: () {},)
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Виберіть дні повторення завдання",
          style: TextStyle(
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.normal
          ),
        ),
        const SizedBox(height: 10),
        // Row with days
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            weekDays.length,
            (index) {
              return DayInWeekLableWidget(dayName: weekDays[index], index: index, selectedDays: selectedDays,);
            }
          )           // DayInWeekLableWidget(dayName: "Пн",)
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SwitchWithLabel(
              state: !isEndless,
              label: "Додати кінцеву",
              callback: (value) => setState(() {
                isEndless = !isEndless;
                if (isEndless == false) {
                  dateOfTheEndText = "${dateOfTheEnd.year}/${dateOfTheEnd.month}/${dateOfTheEnd.day}";
                } else {
                  dateOfTheEndText = "Без кінця";
                }
              })
            ),
            DialogCallButton(
              state: isEndless,
              text: dateOfTheEndText,
              callback: showEndOfRepeatDayDialog,
            ),
          ],
        ),
      ]
    );
  }
}

class DialogCallButton extends StatelessWidget {
  final bool state;
  final String text;
  final Function() callback;

  const DialogCallButton({
    super.key,
    required this.state,
    required this.text,
    required this.callback
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: state ? 
            const Color.fromARGB(255, 231, 231, 231) :
              const Color.fromRGBO(118, 253, 172, 1),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}


class InnerDialogContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const InnerDialogContainer({
    super.key,
    required this.title,
    required this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskFormTitleWidget(title: title),
          SizedBox(
            width: 400,
            height: 300,
            child: Center(
              child: child
            ),
          )
          // CalendarWidget()
        ],
      ),
    );
  }
}

class DialogContainer extends StatelessWidget {
  final List<Widget> children;

  const DialogContainer({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
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
              children: children
            )
          ],
        ),
      ),
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
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
  const TimePickerWidget({
    super.key,
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
  void initState() {
    super.initState();
    hoursController.text = DateTime.now().hour.toString().padLeft(2, '0');
    minutesController.text = DateTime.now().minute.toString().padLeft(2, '0');
  }

  void changeFromAllDay(value) => setState(() {
    fromAllDay = !fromAllDay;
    if (fromAllDay) {
      hoursController.clear();
      minutesController.clear();
      twelveHourFormat = false;
    } else {
      setTime(DateTime.now());
    }
  });

  void changeHoursFormat(value) => setState(() {
    hourFormat = hourFormat == 24 ? 13: 24;
    if (fromAllDay == false) {
      twelveHourFormat = !twelveHourFormat;
    }
    hoursController.clear();
  });

  void setTime(DateTime date) {
    hoursController.text = date.hour.toString().padLeft(2, '0');
    minutesController.text = date.minute.toString().padLeft(2, '0');
  }

  void addTimeToTime(DateTime date) {
    var dateNow = DateTime.now();
    
    var newDate = DateTime(
      dateNow.year,
      dateNow.month,
      dateNow.day,
      dateNow.hour + date.hour,
      dateNow.minute + date.minute
    );
    if (!fromAllDay) {
      setTime(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchWithLabel(
          state: fromAllDay,
          label: "Без часу",
          callback: changeFromAllDay,
        ),
        const SizedBox(height: 5),
        ClockContainerWidget(
          hourInput:NumberInput(
            name: "Години",
            maxValue: hourFormat,
            controller: hoursController,
            enabled: !fromAllDay
          ),
          minuteInput: NumberInput(
            name: "Хвилини",
            maxValue: 60,
            controller: minutesController,
            enabled: !fromAllDay
          ),
          twelveHourFormat: twelveHourFormat
        ),
        const SizedBox(height: 5),
        SwitchWithLabel(
          state: twelveHourFormat,
          label: "AM/PM",
          callback: changeHoursFormat,
        ), 
        const SizedBox(height: 5),   
        TimeTemplatesContainer(
          children: [
            TimeTemplateItem(callback: addTimeToTime,hour: 1,minutes: 0),
            TimeTemplateItem(callback: addTimeToTime,hour: 0,minutes: 30),
            TimeTemplateItem(callback: addTimeToTime,hour: 12,minutes: 0),
            TimeTemplateItem(callback: addTimeToTime,hour: 3,minutes: 45),
          ],
        )  
      ],
    );
  }
}

class TimeTemplateItem extends StatelessWidget {
  final Function(DateTime date) callback;
  final int hour;
  final int minutes;

  const TimeTemplateItem({
    super.key,
    required this.callback,
    required this.hour,
    required this.minutes
  });

  String generateText() {
    String name = "+";
    if (hour > 0) {
      name += "$hour год";
    }
    if (name.length > 1) {
      name += " ";
    }
    if (minutes > 0 ) {
      name += "$minutes хв";
    }
    return name;
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var dateNow = DateTime.now();

        var newDate = DateTime(
          dateNow.year,
          dateNow.month,
          dateNow.day,
          hour,
          minutes
        );

        callback(newDate);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          generateText(),
          style: const TextStyle(
            fontSize: 18
          ),
        ),
      ),
    );
  }
}

class TimeTemplatesContainer extends StatelessWidget {
  final List<Widget> children;

  const TimeTemplatesContainer({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: children,
    );
  }
}

class ClockContainerWidget extends StatelessWidget {
  final Widget hourInput;
  final Widget minuteInput;
  final bool twelveHourFormat;

  const ClockContainerWidget({
    super.key,
    required this.hourInput,
    required this.minuteInput,
    required this.twelveHourFormat
  });
  
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Hours
        Flexible(
          flex: 3,
          child: hourInput
        ),
        const Flexible(
          flex: 0,
          child: DoubleDotTimeDivider()
          ),
        Flexible(
          flex: 3,
          child: minuteInput
        ),
        if (twelveHourFormat)
          const Flexible(
          flex: 2,
          child: AmPmToggleContainer(),
         )
      ],
    );
  } 
}

class SwitchWithLabel extends StatelessWidget {
  final bool state;
  final String label;
  final Function(bool) callback;

  const SwitchWithLabel({
    super.key,
    required this.state,
    required this.label,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {

    return Row(
          children: [
            Switch(
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Icon(Icons.close);
                }
                return null; // All other states will use the default thumbIcon.
              }),
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
              trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                return Colors.white; // Use the default color.
              }),
              trackOutlineWidth: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states) {
                return 2;
              }),
              trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                return Colors.grey[300]!;
              }),
              value: state,
              onChanged: callback,
            ),
            const SizedBox(width: 10,),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                height: 1,
                color: state ? Colors.black : Colors.grey
              )
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
          height: 87,
          constraints: const BoxConstraints(
            maxWidth: 160,
            minWidth: 90
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 23, 10, 2),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
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
              hintText: "00",
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
        // const SizedBox(height: 3),
        // Text(
        //     widget.name,
        //     style: const TextStyle(
        //       fontSize: 15
        //   ),
        // )
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
            side: BorderSide(
              color: Color.fromARGB(255, 225, 255, 237),
              width: 1
            )
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
  final String buttonName;
  
  const 
  
  DateSelectorButton({
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
              Color.fromARGB(255, 255, 255, 255),
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