import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:flutter_todo_project/screens/dialog_task/dialog_task_form.dart';
import 'package:provider/provider.dart';

/// Create the dialog which contains form for createing a new task
class AddNewTaskDialog extends StatelessWidget {
  const AddNewTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(34)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: -5
                  )
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white60, Colors.white10]
                ),
                borderRadius: const BorderRadius.all(Radius.circular(34)),
                border: Border.all(width: 2, color: Colors.white30)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [ChangeNotifierProvider(create: (context) => DateModel(), child: const NewTaskForm())],
                  ))),
            ),
          ),
        ),
      ),
    );
  }
}

