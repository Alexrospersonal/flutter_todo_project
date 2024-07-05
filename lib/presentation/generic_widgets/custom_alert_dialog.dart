import 'package:flutter/material.dart';

class CustomAlerDialog extends StatelessWidget {

  final String? title;
  final String errorMessage;

  const CustomAlerDialog({
    super.key,
    required this.errorMessage,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!): null,
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Зрозуміло")
          )
        ],
      ),
    );
  }
}
