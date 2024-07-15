import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/domain/state/task_state.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/cards/calendar_card.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/cards/date_done_button_card.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/cards/date_selector_card.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/cards/date_title_card.dart'; 
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/date_settings_widget.dart';
import 'package:flutter_todo_project/presentation/screens/date_selector_dialog/wide_done_button.dart';
import 'package:provider/provider.dart';

class DateSelectorWidget extends StatefulWidget {
  final TaskState taskState;

  const DateSelectorWidget({
    super.key,
    required this.taskState
  });

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget>  with WidgetsBindingObserver{
  bool isFirstLarge = true;
  bool isKeyboardVisible = false;
  Duration animDuration = const Duration(milliseconds: 100);

  double minHeight = 0.25;
  double maxHeight = 0.60 - 0.01;
  double titleHeight = 0.07;
  double doneButtonHeight = 0.07;

  double padding = 8.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();  
    final bottomInset = View.of(context).viewInsets.bottom;
    setState(() {
      isKeyboardVisible = bottomInset > 0.0;
    });
  }

  void _toggleSizes(bool res) {
    if (!isKeyboardVisible) {
      setState(() {
        isFirstLarge = res;
      });
    }
  }

  void _swipeToggleHandler(DragUpdateDetails details) {
    if (details.primaryDelta! < -10) {
      // print("Swipe Up");
      if (isFirstLarge) {
        _toggleSizes(false);
      }
    }
    else if (details.primaryDelta! > 10) {
      // print("Swipe Down");
      if (!isFirstLarge) {
        _toggleSizes(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - padding * 4;
    double paddingHeight = screenHeight * 0.01;

    double maxSize = screenHeight * maxHeight;
    double minSize = screenHeight * minHeight;

    return ChangeNotifierProvider.value(
      value: widget.taskState,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg1.jpg'),
              fit: BoxFit.cover,
              opacity: 0.75,
            ),
            color: Colors.black
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onVerticalDragUpdate: _swipeToggleHandler,
              child: Padding(
                padding: EdgeInsets.fromLTRB(padding, padding * 3, padding, 0),
                child: Column(
                  children: <Widget>[
                    DateTitleCardWidget(
                      screenHeight: screenHeight,
                      titleHeight: titleHeight,
                      child: const TaskFormTitleWidget(title: "дата та час"),
                    ),
                    if (!isKeyboardVisible)
                    DateSelectorCardWidget(
                      minSize: minSize,
                      maxSize: maxSize,
                      isFirstLarge: isFirstLarge,
                      toggleSizes: _toggleSizes,
                      isTop: true,
                      child: const CalendarCardWidget(),
                    ),
                    SizedBox(height: paddingHeight),
                    DateSelectorCardWidget(
                      minSize: minSize,
                      maxSize: isKeyboardVisible ? maxSize - 95: maxSize,
                      isFirstLarge: !isFirstLarge,
                      toggleSizes: _toggleSizes,
                      isTop: false,
                      child: const DateSettingsWidget()
                    ),
                    SizedBox(height: paddingHeight),
                    DateDoneButtonCardWidget(
                      screenHeight: screenHeight,
                      doneButtonHeight: doneButtonHeight,
                      child: WideDoneButton(action: () {}),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } 
}

class InnerDialogContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const InnerDialogContainer({
    super.key,
    required this.title,
    required this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskFormTitleWidget(title: title),
              child
              // CalendarWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class DialogContainer extends StatelessWidget {
  final List<Widget> children;

  const DialogContainer({
    super.key,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ...children,
                Positioned(
                  left: 155-30,
                  right: 155-30,
                  bottom: -25,
                  child: DoneButton(action: () => true,)
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}

