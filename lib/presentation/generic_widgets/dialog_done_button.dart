import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class DoneButton extends StatelessWidget {
  final bool Function() action;

  const DoneButton({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 32,
      child: ElevatedButton(
        onPressed: () {
          bool res = action();
          if (res) {
            Navigator.of(context).pop();
          }
        },
        style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
        child: Text(
          S.of(context).confirmVuttonLabel,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).canvasColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
