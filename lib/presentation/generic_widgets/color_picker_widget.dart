// TODO: Розібратись з фокусом і клавіатуро. Чому фокус вертається до текстового поля.??
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final _overlayController = OverlayPortalController();
  final FocusNode _overlayFocusNode = FocusNode();

  late RenderBox iconContainerRenderBox;

  Color activeColor = Colors.lime;

  List<Color> icons = [
    Colors.deepPurple,
    const Color.fromARGB(255, 199, 228, 35),
    const Color.fromARGB(255, 230, 201, 40),
    const Color.fromARGB(255, 40, 186, 230)
  ];

  void changeActiveColor(int idx) {
    setState(() {
      activeColor = icons[idx];
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
    Size parrentSize = MediaQuery.of(context).size;
    double outerWidth = parrentSize.width;
    double outerHeight = parrentSize.height;

    return GestureDetector(
      onTap: () {
        _overlayController.toggle();
        _overlayFocusNode.requestFocus();
      },
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
              top: outerHeight * 0.54,
              right: (outerWidth - 45) * 0.12,
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
                    ]
                    ),
                  child: IntrinsicHeight(
                    child: Column(
                        children: List.generate(
                            icons.length,
                            (index) => ListTile(
                                  focusNode: _overlayFocusNode,
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  title: Container(
                                    // padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 214, 214, 214)
                                    ),
                                    child: Icon(Icons.circle, color: icons[index])
                                    ),
                                  onTap: () {
                                    changeActiveColor(index);
                                  },
                                ))),
                  )));
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Icon(Icons.circle, color: activeColor),
        ),
      ),
    );
  }
}
