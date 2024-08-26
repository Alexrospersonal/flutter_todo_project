import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class GenericPickerDialog extends StatelessWidget {
  final double height;
  final List<Widget> children;
  final void Function() callback;

  const GenericPickerDialog(
      {super.key,
      required this.children,
      required this.callback,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: Theme.of(context).cardColor.withOpacity(0.76),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bigBorderRadius)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Container(
          height: height,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...children,
              Positioned(
                left: 110,
                right: 110,
                bottom: -8,
                child: DoneButton(
                  action: () {
                    callback();
                    return true;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
