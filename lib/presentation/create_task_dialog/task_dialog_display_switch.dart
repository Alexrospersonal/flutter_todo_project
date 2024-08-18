import 'package:flutter/material.dart';

class TaskDialogDisplaySwitch extends StatelessWidget {
  final IconData iconData;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final String buttonName;

  const TaskDialogDisplaySwitch(
      {super.key,
      required this.iconData,
      required this.index,
      required this.selectedIndex,
      required this.onItemTapped,
      required this.buttonName});

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;

    Padding text = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: Text(
          overflow: TextOverflow.ellipsis,
          buttonName,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Theme.of(context).cardColor),
        ),
      ),
    );

    Icon icon = Icon(
      iconData,
      size: 16,
      color: Theme.of(context).cardColor,
    );

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
          // margin: const EdgeInsets.all(7),
          height: 32,
          width: isSelected ? 90 : 32,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: isSelected ? text : icon,
          )),
    );
  }
}
