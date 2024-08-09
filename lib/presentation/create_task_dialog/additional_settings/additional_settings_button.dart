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
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.fromLTRB(15, 0, 10, 0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).additionalSettingLabel,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w400)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).iconTheme.color,
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
