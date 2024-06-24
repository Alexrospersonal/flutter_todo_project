import 'package:flutter/material.dart';

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