import 'dart:ui';

Color darkenColor(Color color, {double amount = 0.1}) {
  assert(amount >= 0 && amount <= 1);

  int red = (color.red * (1 - amount)).round();
  int green = (color.green * (1 - amount)).round();
  int blue = (color.blue * (1 - amount)).round();

  return Color.fromARGB(color.alpha, red, green, blue);
}