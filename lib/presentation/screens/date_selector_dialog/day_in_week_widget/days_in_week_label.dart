import 'package:flutter/material.dart';

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