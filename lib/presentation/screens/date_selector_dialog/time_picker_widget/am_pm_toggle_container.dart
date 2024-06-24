import 'package:flutter/material.dart';

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