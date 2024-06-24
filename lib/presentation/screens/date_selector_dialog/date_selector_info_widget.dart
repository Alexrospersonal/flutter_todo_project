import 'package:flutter/material.dart';

class DateSelectorInfoWidget extends StatelessWidget {
  const DateSelectorInfoWidget({super.key});
  
  @override
  Widget build(Object context) {
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
      child: const SingleChildScrollView(
        child: Column(
          children: [
            ListInfoItem(label: "Дата", text: "26/05/2025",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Година", text: "18:00",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Повторення", text: "Вт, Пт, Нд",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Тривалість", text: "4 год. 18 хв.",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
            ListInfoItem(label: "Нагадати за", text: "дні: 1, год: 4, хв: 17",),
            Divider(color: Color.fromRGBO(118, 253, 172, 1)),
            SizedBox(height: 10),
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