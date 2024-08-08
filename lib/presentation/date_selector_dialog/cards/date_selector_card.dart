import 'package:flutter/material.dart';

class DateSelectorCardWidget extends StatelessWidget {
  final double minSize;
  final double maxSize;
  final bool isFirstLarge;
  final void Function(bool) toggleSizes;
  final bool isTop;
  final Widget child;

  const DateSelectorCardWidget({
    super.key,
    required this.minSize,
    required this.maxSize,
    required this.isFirstLarge,
    required this.toggleSizes,
    required this.isTop,
    required this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleSizes(isTop);
      },
      child: Opacity(
        opacity: isFirstLarge == false ? 0.35 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.75),
          ),
          height: isFirstLarge ? maxSize : minSize,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IgnorePointer(
              ignoring: isFirstLarge == true ? false : true,
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          )
        ),
      ),
    );
  }
}