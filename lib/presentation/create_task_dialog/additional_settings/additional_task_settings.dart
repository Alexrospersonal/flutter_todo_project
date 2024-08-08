import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_button.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_container.dart';

class AdditionalTaskSetting extends StatefulWidget {
  const AdditionalTaskSetting({
    super.key,
  });

  @override
  State<AdditionalTaskSetting> createState() => _AdditionalTaskSettingState();
}

class _AdditionalTaskSettingState extends State<AdditionalTaskSetting> {
  bool isExpanded = false;

  void switchExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> additionalParams = [
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalDateLabel,
        icon: Icons.calendar_month,
        callback: () {},
      ),
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalTimeLabel,
        icon: Icons.schedule_rounded,
        callback: () {},
      ),
            AdditionalSettingInput(
        buttonLabel: S.of(context).additionalDurationLabel,
        icon: Icons.timer,
        callback: () {},
      ),
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalNotificationLabel,
        icon: Icons.notifications,
        callback: () {},
      ),
      AdditionalSettingInput(
        buttonLabel: S.of(context).additionalRepeatLabel,
        icon: Icons.repeat,
        callback: () {},
      )
    ];

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isExpanded
          ? AdditionalSettingsContainer(
              callback: switchExpanded, children: additionalParams)
          : AdditionalSettingsButton(callback: switchExpanded),
    );
  }
}

class AdditionalSettingInput extends StatefulWidget {
  final String buttonLabel;
  final IconData icon;
  final void Function() callback;

  const AdditionalSettingInput(
      {super.key,
      required this.buttonLabel,
      required this.icon,
      required this.callback});

  @override
  State<AdditionalSettingInput> createState() => _AdditionalSettingInputState();
}

class _AdditionalSettingInputState extends State<AdditionalSettingInput> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    var offTextStyle = Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(fontWeight: FontWeight.normal);
    var onTextStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSurface);

    Color iconColor = state ? onTextStyle.color! : offTextStyle.color!;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 32,
              child: ElevatedButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10))),
                onPressed: () {
                  if (state) {
                    widget.callback();
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.buttonLabel,
                        style: state ? onTextStyle : offTextStyle),
                    Icon(
                      widget.icon,
                      color: iconColor,
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        Switch(
          value: state,
          onChanged: (value) {
            setState(() {
              state = value;
            });
            if (state) {
              widget.callback();
            }
          },
        )
      ],
    );
  }
}
