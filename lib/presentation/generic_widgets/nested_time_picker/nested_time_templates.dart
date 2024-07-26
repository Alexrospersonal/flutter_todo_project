import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/utils/time_controller.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class NestedTimeTemplates extends StatelessWidget {
  final void Function(TimeController time) callback;
  final TimeController currentTime;

  const NestedTimeTemplates({
    super.key,
    required this.currentTime,
    required this.callback
  });
  
  @override
  Widget build(BuildContext context) {
    final bool is24HourFormat =  MediaQuery.of(context).alwaysUse24HourFormat;
    var factory = is24HourFormat ? Time24ControllerFactory() : Time12ControllerFactory();
    var time = getTemplatesData(currentTime, factory);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale1,
          newTime: time["5m"]!,
        ),
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale2,
          newTime: time["30m"]!,
        ),
        NestedTimePickerTemplateButton(
          callback: callback,
          currentTime: currentTime,
          buttonText: S.of(context).timePickerTempale3,
          newTime: time["1h"]!,
        ),
      ]
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

  final void Function(TimeController time) callback;
  final String buttonText;
  final TimeController currentTime;
  final TimeController newTime;

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

Map<String, TimeController> getTemplatesData(TimeController currentTime, TimeControllerFactory factory) {
return {
    "5m": factory.createTimeController(
      currentTime.hour,
      currentTime.minute + 5,
      amPm: currentTime.amPm
    ),
    "30m": factory.createTimeController(
      currentTime.hour,
      currentTime.minute + 30,
      amPm: currentTime.amPm
    ),
    "1h": factory.createTimeController(
      currentTime.hour + 1,
      currentTime.minute,
      amPm: currentTime.amPm
    ),
  };
}
