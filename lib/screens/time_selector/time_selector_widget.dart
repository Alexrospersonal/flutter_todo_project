import 'package:flutter/material.dart';
import 'package:flutter_todo_project/screens/date/date_model.dart';
import 'package:provider/provider.dart';

class TimeSelectorWidget extends StatefulWidget {
  const TimeSelectorWidget({super.key});

  @override
  State<TimeSelectorWidget> createState() => _TimeSelectorWidgetState();
}

class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  Future<void> _selectTime() async {
    var initTime =
        Provider.of<DateModel>(context, listen: false).getTimeOfDay();

    var time = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!);
      },
    );

    if (!mounted) return;

    if (time != null) {
      Provider.of<DateModel>(context, listen: false)
          .changeTime(time.hour, time.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: () async {
            await _selectTime();
          },
          child: const Text("Select time"))
    ]);
  }
}
