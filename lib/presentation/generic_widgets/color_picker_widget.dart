import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final _overlayController = OverlayPortalController();
  final FocusNode _overlayFocusNode = FocusNode();

  late RenderBox iconContainerRenderBox;

  void changeActiveColor(BuildContext context, int idx) {
    context.read<TaskNotifier>().setColor(taskColors[idx]);
    _overlayController.hide();
    setState(() {
      _overlayController.hide();
    });
  }

  void _onOverlayFocusChange() {
    if (!_overlayFocusNode.hasFocus) {
      _overlayController.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    _overlayFocusNode.addListener(_onOverlayFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _overlayFocusNode.removeListener(_onOverlayFocusChange);
    _overlayFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset overlayPosition = Offset.zero;

    return Selector<TaskNotifier, Color>(
      selector: (context, taskNotifier) => taskNotifier.color,
      builder: (context, color, child) {
        return Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _overlayController.toggle();
              _overlayFocusNode.requestFocus();
            },
            onTapDown: (details) {
              overlayPosition = details.globalPosition - details.localPosition;
            },
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(smallBorderRadius)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).color,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    OverlayPortal(
                      controller: _overlayController,
                      overlayChildBuilder: (context) {
                        return Positioned(
                            top: overlayPosition.dy - 55,
                            left: overlayPosition.dx + 30,
                            child: PhysicalShape(
                              color: Colors.white,
                              clipper: RoundedRectWithTailClipper(),
                              elevation: 5.0, // Параметр для додавання тіні
                              shadowColor: Colors.black.withOpacity(0.5),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      taskColors.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          changeActiveColor(context, index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.circle,
                                              color: taskColors[index]),
                                        ),
                                      ),
                                    )),
                              ),
                            ));
                      },
                      child: Icon(
                        Icons.circle,
                        color: color,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RoundedRectWithTailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 8;
    double tiltHeight = 10;

    return Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - (radius + tiltHeight))
      ..arcToPoint(Offset(size.width - radius, size.height - tiltHeight),
          radius: Radius.circular(radius))
      ..lineTo(size.width / 2 + 10, size.height - tiltHeight)
      ..quadraticBezierTo(size.width / 2, size.height + 5, size.width / 2 - 10,
          size.height - tiltHeight)
      ..lineTo(radius, size.height - tiltHeight)
      ..arcToPoint(Offset(0, size.height - (radius + tiltHeight)),
          radius: Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
