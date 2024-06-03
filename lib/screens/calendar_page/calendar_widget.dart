import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime month;

  const CalendarWidget({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> calendar = buildCalendar(month);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 колонок для днів тижня
      ),
      itemCount: calendar.length,
      itemBuilder: (context, index) {
        DateTime day = calendar[index];
        bool isCurrentMonth = day.month == month.month;

        return Container(
          alignment: Alignment.center,
          color: isCurrentMonth ? Colors.white : Colors.grey[300], // Колір фону в залежності від того, чи належить день поточному місяцю
          child: Text(
            '${day.day}', // Відображення числа дня
            style: TextStyle(
              color: isCurrentMonth ? Colors.black : Colors.grey[600], // Колір тексту
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  List<DateTime> buildCalendar(DateTime month) {
    // Отримуємо перший день місяця
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);

    // Визначаємо, який день тижня це
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    // Отримуємо останній день місяця
    DateTime lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    // Визначаємо кількість днів у попередньому місяці
    int daysInPrevMonth = DateTime(month.year, month.month, 0).day;

    // Розраховуємо кількість днів поточного місяця
    int daysInMonth = lastDayOfMonth.day;

    // Визначаємо, скільки днів попереднього місяця потрібно включити в календар
    int prevDaysToShow = weekdayOfFirstDay - 1; // Віднімаємо 1, оскільки понеділок - 1

    // Створюємо список дат місяця
    List<DateTime> calendar = [];

    // Додаємо дні попереднього місяця
    for (int i = prevDaysToShow; i > 0; i--) {
      DateTime day = DateTime(month.year, month.month - 1, daysInPrevMonth - i + 1);
      calendar.add(day);
    }

    // Додаємо дні поточного місяця
    for (int i = 0; i < daysInMonth; i++) {
      DateTime day = DateTime(month.year, month.month, i + 1);
      calendar.add(day);
    }

    // Додаємо дні наступного місяця, якщо потрібно
    int nextDaysToShow = (7 - (calendar.length % 7)) % 7; // Кількість днів, що не вистачає до повного тижня
    for (int i = 0; i < nextDaysToShow; i++) {
      DateTime day = DateTime(month.year, month.month + 1, i + 1);
      calendar.add(day);
    }

    return calendar;
  }
}
