import 'package:flutter/material.dart';

class DayInWeekLableWidget extends StatelessWidget {
  
  final String dayName;
  final int index;
  final bool selectedDay;
  final void Function(int) callback;

  const DayInWeekLableWidget({
    super.key,
    required this.dayName,
    required this.index,
    required this.selectedDay,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          callback(index);
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selectedDay ?
              const Color.fromRGBO(118, 253, 172, 1) :
                const Color.fromARGB(255, 241, 241, 241)
          ),
          child:Center(
            child: Text(
              dayName,
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