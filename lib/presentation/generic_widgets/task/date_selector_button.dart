
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/date_selector_widget.dart';
import 'package:provider/provider.dart';

class DateSelectorButton extends StatefulWidget {
  const DateSelectorButton({super.key});

  @override
  State<DateSelectorButton> createState() => _DateSelectorButtonState();
}

class _DateSelectorButtonState extends State<DateSelectorButton> {
  final String _datetext = "Щовівторка";
  final String _timetext = "18:00";

  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskState>(context, listen: false);

    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DateSelectorWidget(taskState: taskState)));
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 0)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 6, horizontal: 10)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.calendar_month),
          const SizedBox(width: 3),
          Text(
            _datetext,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(width: 7),
          const Icon(Icons.timelapse),
          const SizedBox(width: 3),
          Text(
            _timetext,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w400
            ),
          ),
        ]));
  }
}
