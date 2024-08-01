import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class AnimatedWeekProgressDiagrammData {
  var textStyle = ui.TextStyle(color: greyColor, fontSize: 10, height: 1);

  List<String> getShortWeekdays() {
    final dateFormat = DateFormat('EEE');

    List<String> shortWeekdays = List.generate(7, (index) {
      final date = DateTime.utc(2024, 1, 1).add(Duration(days: index));
      return dateFormat.format(date);
    });

    return shortWeekdays.reversed.toList();
  }

  Gradient gradient = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      onPrimaryColor,
      primaryColorWithOpacity,
      primaryColor,
    ],
    stops: [0.2, 0.6, 1],
  );

  List<String> percents = ["0%", "25%", "50%", "75%", "100%"];

  List<double> percentTextWidth = List<double>.generate(
      5,
      (int pos) => pos == 0
          ? 15
          : pos != 4
              ? 20
              : 25);

  ui.ParagraphBuilder createParagraphBuilder(ui.TextStyle textStyle, double fontSize) {
    ui.ParagraphBuilder paragraphBuilder =
        ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: fontSize, fontWeight: FontWeight.w500, textAlign: TextAlign.right));
    paragraphBuilder.pushStyle(textStyle);

    return paragraphBuilder;
  }

  ui.Paragraph getParagraph(ui.ParagraphBuilder paragraphBuilder, double constraintWidth) {
    ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: constraintWidth));

    return paragraph;
  }

  ui.ParagraphBuilder addText(String text) {
    var builder = createParagraphBuilder(
      textStyle,
      10,
    );
    builder.addText(text);
    return builder;
  }
}
