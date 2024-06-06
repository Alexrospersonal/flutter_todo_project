import 'package:flutter/material.dart';

class PriorityButton extends StatefulWidget {
  const PriorityButton({super.key});

  @override
  State<PriorityButton> createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {
  bool _isPriority = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPriority = !_isPriority;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Icon(Icons.star_sharp, color: _isPriority ? Colors.amber : Colors.grey),
      ),
    );
  }
}
