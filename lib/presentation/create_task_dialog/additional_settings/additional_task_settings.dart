import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_button.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_settings_container.dart';

class AdditionalTaskSetting extends ConsumerStatefulWidget {
  const AdditionalTaskSetting({
    super.key,
  });

  @override
  ConsumerState<AdditionalTaskSetting> createState() =>
      _AdditionalTaskSettingState();
}

class _AdditionalTaskSettingState extends ConsumerState<AdditionalTaskSetting> {
  void switchExpanded(bool isExpanded) {
    ref.read(initialTaskDialogExpandedProvider.notifier).state = !isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(initialTaskDialogExpandedProvider);

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: isExpanded
            ? AdditionalSettingsContainer(
                callback: () => switchExpanded(isExpanded),
                children: additionalParams)
            : AdditionalSettingsButton(
                callback: () => switchExpanded(isExpanded)),
      ),
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
