
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';

class NotifiacationDateSelectorDialog extends StatefulWidget {
  final List<Widget> children;
  final Function()? callback;

  const NotifiacationDateSelectorDialog({
    super.key,
    required this.children,
    this.callback
  });

  @override
  State<NotifiacationDateSelectorDialog> createState() => _NotifiacationDateSelectorDialogState2();
}

class _NotifiacationDateSelectorDialogState2 extends State<NotifiacationDateSelectorDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(34)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: -5)],
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white60, Colors.white10]),
                    borderRadius: const BorderRadius.all(Radius.circular(34)),
                    border: Border.all(width: 2, color: Colors.white30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: SingleChildScrollView(
                        child: Column(
                          children: widget.children,
                        )
                      )
                    ),
                ),
              ),
            ),
            Positioned(
              left: 155-30,
              right: 155-30,
              bottom: -8,
              child: DoneButton(action: () {
                if (widget.callback != null) {
                  widget.callback!();
                  return true;
                }
                return false;
              })
            )
          ],
        ),
      ),
    );
  }
}