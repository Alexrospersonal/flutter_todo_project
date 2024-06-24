import 'package:flutter/material.dart';

class TimeTemplatesContainer extends StatelessWidget {
  final List<Widget> children;

  const TimeTemplatesContainer({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: children,
    );
  }
}