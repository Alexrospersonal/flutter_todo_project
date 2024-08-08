import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class AdditionalSettingsContainer extends StatelessWidget {
  final List<Widget> children;
  final void Function() callback;

  const AdditionalSettingsContainer(
      {super.key, required this.callback, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(smallBorderRadius),
              border: Border(
                top: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).primaryColor), // Верхня рамка
                bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).primaryColor), // Нижня рамка
              ),
            ),
            child: Column(children: children,),
          ),
          Positioned(
            top: -10,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              color: Theme.of(context).cardColor,
              child: Text(S.of(context).additionalSettingLabel,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          // Touch element
          Positioned(
            top: -10,
            left: 10,
            child: GestureDetector(
              onTap: () => callback(),
              child: Container(
                height: 20,
                width: 300,
                color: Colors.transparent
              ),
            ),
          ),
        ],
      ),
    );
  }
}


