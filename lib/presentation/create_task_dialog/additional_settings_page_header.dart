import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class AdditionalSettingsPageHeader extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function(bool) callback;
  final bool state;

  const AdditionalSettingsPageHeader(
      {super.key,
      required this.text,
      required this.iconData,
      required this.callback,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(smallBorderRadius),
                  color: Theme.of(context).canvasColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Icon(iconData)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Switch(
            value: state,
            onChanged: (value) => callback(value),
          )
        ],
      ),
    );
  }
}
