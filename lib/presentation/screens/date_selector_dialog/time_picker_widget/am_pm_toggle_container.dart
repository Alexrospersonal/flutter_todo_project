import 'package:flutter/material.dart';

class AmPmToggleContainer extends StatefulWidget {
  final void Function(String) callback;
  final List<bool> isSelected;

  const AmPmToggleContainer({
    super.key,
    required this.isSelected,
    required this.callback
  });

  @override
  State<AmPmToggleContainer> createState() => _AmPmToggleContainerState();
}

class _AmPmToggleContainerState extends State<AmPmToggleContainer> {

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
      isSelected: widget.isSelected,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < widget.isSelected.length; i++) {
            widget.isSelected[i] = i == index;
          }
          widget.callback(index == 0 ? "am" : "pm");
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