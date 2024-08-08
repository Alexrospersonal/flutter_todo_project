import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class AdditionalSettingsButton extends StatelessWidget {
  final void Function() callback;

  const AdditionalSettingsButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () => callback(),
                child: Text(S.of(context).additionalSettingLabel,
                    style: Theme.of(context).textTheme.labelMedium!),
              )),
        ),
      ],
    );
  }
}