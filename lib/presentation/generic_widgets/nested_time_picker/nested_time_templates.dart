import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/time_controller.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class NestedTimeTemplates extends StatelessWidget {
  final void Function(Time12Controller time) callback;
  final Time12Controller currentTime;

  const NestedTimeTemplates({
    super.key,
    required this.currentTime,
    required this.callback
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale1,
          newTime: Time12Controller(
            hour: currentTime.hour,
            minute: currentTime.minute + 5,
            amPm: currentTime.amPm
          ),
        ),
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale2,
          newTime: Time12Controller(
            hour: currentTime.hour,
            minute: currentTime.minute + 30,
            amPm: currentTime.amPm
          ),
        ),
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale3,
          newTime: Time12Controller(
            hour: currentTime.hour + 1,
            minute: currentTime.minute,
            amPm: currentTime.amPm
          ),
        ),
      ],
    );
  }
}

class NestedTimePickerTemplateButton extends StatelessWidget {
  const NestedTimePickerTemplateButton({
    super.key,
    required this.callback,
    required this.currentTime,
    required this.newTime,
    required this.buttonText
  });

  final void Function(Time12Controller time) callback;
  final String buttonText;
  final Time12Controller currentTime;
  final Time12Controller newTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        fixedSize: WidgetStatePropertyAll<Size>(Size(70, 32)),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero)
      ),
      onPressed: () {
        callback(
          newTime
        );
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
        ),
      )
    );
  }
}