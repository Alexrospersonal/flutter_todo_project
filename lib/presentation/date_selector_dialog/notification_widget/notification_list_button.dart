import 'package:flutter/material.dart';

class NotificationListButton extends StatelessWidget {
  final void Function() callback;
  final int index;
  final bool state;
  final Color activeColor;

  final IconData? icon;
  final String? text;

  const NotificationListButton({
    super.key,
    required this.index,
    required this.callback,
    required this.state,
    required this.activeColor,
    this.icon,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => callback(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: !state ? Colors.white : activeColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Icon(
                icon,
                color: state ? Colors.black: Colors.grey, 
                ) : const SizedBox.shrink(),
              if (text != null)
                const SizedBox(width: 3),
              if (text != null)
                Text(
                  text!,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}