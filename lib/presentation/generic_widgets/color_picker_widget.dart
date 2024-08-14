// TODO: Розібратись з фокусом і клавіатуро. Чому фокус вертається до текстового поля.??
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/styles/generic_styles.dart';
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
    context.read<TaskState>().setColor(taskColors[idx]);
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

    return Selector<TaskState, Color>(
      selector: (context, taskState) => taskState.color,
      builder: (context, color, child) {
        return GestureDetector(
          onTap: () {
            _overlayController.toggle();
            _overlayFocusNode.requestFocus();
          },
          onTapDown: (details) {
            overlayPosition = details.globalPosition - details.localPosition;
          },
          child: OverlayPortal(
            controller: _overlayController,
            overlayChildBuilder: (context) {
              return Positioned(
                  top: overlayPosition.dy,
                  left: overlayPosition.dx - 7,
                  child: Container(
                      alignment: const Alignment(0, 0),
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: IntrinsicHeight(
                        child: Column(
                            children: List.generate(
                                taskColors.length,
                                (index) => ListTile(
                                      focusNode: _overlayFocusNode,
                                      dense: true,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: EdgeInsets.zero,
                                      title: Container(
                                          // padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromARGB(
                                                  255, 214, 214, 214)),
                                          child: Icon(Icons.circle,
                                              color: taskColors[index])),
                                      onTap: () {
                                        changeActiveColor(context, index);
                                      },
                                    ))),
                      )));
            },
            child: Container(
              // padding: const EdgeInsets.all(6),
              width: 31,
              height: 31,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Icon(
                Icons.circle,
                color: color,
                size: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
