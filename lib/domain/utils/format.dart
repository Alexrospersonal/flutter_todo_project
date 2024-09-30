import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:intl/intl.dart';

String formatDate(Locale locale, DateTime date) {
  late DateFormat dateFormat;

  switch (locale.countryCode) {
    case 'US':
      dateFormat = DateFormat('MM/dd/yyyy');
    case 'GB':
      dateFormat = DateFormat('dd/MM/yyyy');
    default:
      dateFormat = DateFormat('dd/MM/yyyy');
  }

  return dateFormat.format(date);
}

String formatTime(DateTime time, BuildContext context) {
  final bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
  if (is24HourFormat) {
    return "${time.hour}:${time.minute}";
  }
  return DateFormat("hh:mm a", "en_US").format(time);
}

List<String> repeatlyDaysAsStrings(S s, List<bool> repetlyDates) {
  final dateFormat = DateFormat('EEE');

  final List<String> formattedDates = repetlyDates
      .asMap()
      .entries
      .where((entry) => entry.value) // Фільтруємо записи, де значення true
      .map((entry) {
    final date = DateTime.utc(2024, 1, 1).add(Duration(days: entry.key));
    return dateFormat.format(date); // Форматуємо дату
  }).toList(); // Перетворюємо результат в список

  if (formattedDates.length == 7) {
    return [s.week];
  }
  return formattedDates.isEmpty ? [s.none] : formattedDates;
}

List<String> repeatlyTimesAsStrings(List<DateTime?> times) {
  return times.map<String>((date) {
    return date != null ? "X" : "-";
  }).toList();
}

List<String> repeatlyDaysAsUpperChar() {

  /* This code help's to create a smart selecting of first weekday.
  MaterialLocalizations localizations = MaterialLocalizations.of(context);

  String firstStringDayOfWeek =
      localizations.narrowWeekdays[localizations.firstDayOfWeekIndex];
  var firstDayOfWeek = localizations.firstDayOfWeekIndex;
  */

  final dateFormat = DateFormat('E');

  final DateTime now = DateTime.now();

  final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

  return List.generate(7, (index) {
    final DateTime day = startOfWeek.add(Duration(days: index));
    return dateFormat.format(day)[0].toUpperCase();
  });
}
