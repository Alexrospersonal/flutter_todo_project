import 'package:flutter/material.dart';

class TaskPageViewContainer extends StatelessWidget {
  final List<Widget> children;
  final PageController pageController;
  final void Function(int) onPageChanged;

  const TaskPageViewContainer(
      {super.key,
      required this.pageController,
      required this.children,
      required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
      child: SizedBox(
        height: 470,
        child: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: children),
      ),
    );
  }
}
