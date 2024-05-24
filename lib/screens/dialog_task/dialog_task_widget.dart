import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/dialog_task/dialog_task_form.dart';

/// Class for dialog menu widget,
/// create dialog window with the new task form.
// class AddNewTaskDialog extends StatelessWidget {
//   const AddNewTaskDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       title: const Center(
//         child: Text('-Створити нове завдання-'),
//       ),
//       backgroundColor: Colors.white.withOpacity(0.1),
//       alignment: Alignment.center,
//       children: const [
//         SingleChildScrollView(
//             child: Padding(
//           padding: EdgeInsets.all(25.0),
//           child: NewTaskForm(),
//         ))
//       ],
//     );
//   }
// }

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text('Create new Task'),
                SizedBox(height: 15),
                NewTaskForm()
              ],
            ))),
      ),
    );
  }
}
