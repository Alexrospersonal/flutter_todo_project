
import 'package:flutter/cupertino.dart';

class NotificationTextContainer extends StatelessWidget {
  final String text;
  final String number;

  const NotificationTextContainer({
    super.key,
    required this.number,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.w600
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            height: 1,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}