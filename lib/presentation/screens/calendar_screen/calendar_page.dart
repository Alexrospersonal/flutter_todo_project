import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            // child: CalendarWidget(),
            child: Placeholder(),
          )),
          // Expanded(child: Placeholder())
        ],
      ),
    );
  }
}
