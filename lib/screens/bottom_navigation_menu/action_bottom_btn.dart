import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/dialog_task/dialog_task_widget.dart';

class ActionBottomButton extends StatelessWidget {
  const ActionBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddTaskDialog(context),
      child: const Icon(Icons.add),
    );
  }
  void _showAddTaskDialog(BuildContext context) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Add Task",
        barrierColor: Colors.transparent,
        pageBuilder: (context, anim1, anim2) {
          return const AddNewTaskDialog();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      );
    }
  // void _showAddTaskDialog(BuildContext context) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: "Add Task",
  //     barrierColor: Colors.white.withOpacity(0.2),
  //     pageBuilder: (context, anim1, anim2) {
  //       return Center(
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(15.0),
  //           child: BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //             child: const AddNewTaskDialog(),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(
  //         opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
  //         child: child,
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 200),
  //   );
  // }
}
