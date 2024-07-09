import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateSelectorInfoWidget extends StatelessWidget {
  const DateSelectorInfoWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    TaskState state = context.watch<TaskState>();

    String date = state.taskDateTime != null ? DateFormat('dd/MM/yyyy').format(state.taskDateTime!) :"Без дати";

    String time = state.hasTime ? DateFormat(DateFormat.HOUR24_MINUTE).format(state.taskDateTime!) : "Без години";

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius:BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 1
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListInfoItem(label: "Дата", text: date,),
            const Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            const SizedBox(height: 10),
            ListInfoItem(label: "Година", text: time,),
            const Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            const SizedBox(height: 10),
            ListInfoItem(label: "Повторення", text: "Вт, Пт, Нд",),
            const Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            const SizedBox(height: 10),
            ListInfoItem(label: "Тривалість", text: "4 год. 18 хв.",),
            const Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            const SizedBox(height: 10),
            ListInfoItem(label: "Нагадати за", text: "дні: 1, год: 4, хв: 17",),
            const Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  
}

class ListInfoItem extends StatelessWidget {
  final String label;
  final String text;

  const ListInfoItem({
    super.key,
    required this.label,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}