import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_form_title.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_clock.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_date_selector_dialog.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_list_button.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_text_container.dart';

class NotifiactionListItemContainer extends StatefulWidget {
  const NotifiactionListItemContainer({super.key});

  @override
  State<NotifiactionListItemContainer> createState() =>
      _NotifiactionListItemContainerState();
}

class _NotifiactionListItemContainerState
    extends State<NotifiactionListItemContainer> {
  bool notificationButtonsState = false;

  void deleteNotification() {
    setState(() {
      notificationButtonsState = false;
    });
  }

  void showSetNotificationDialog() {
    setState(() {
      notificationButtonsState = true;
    });

    if (notificationButtonsState) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.5),
        builder: (context) {
          return NotifiacationDateSelectorDialog(
            children: const [
              TaskFormTitleWidget(title: "Дата нагадування"),
              SizedBox(height: 10),
              NotificationClockWidget(),
              SizedBox(height: 25),
            ],
            callback: () {
              // print("Babuna macaca");
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Row with add and delete buttons and text
        Row(
          children: [
            NotificationListButton(
              index: 0,
              callback: showSetNotificationDialog,
              state: !notificationButtonsState,
              activeColor: const Color.fromRGBO(118, 253, 172, 1),
              icon: Icons.notification_add,
            ),
            const SizedBox(width: 5),
            NotificationListButton(
              index: 0,
              callback: deleteNotification,
              state: notificationButtonsState,
              activeColor: const Color.fromARGB(255, 250, 166, 56),
              icon: Icons.edit_notifications,
            ),
            const SizedBox(width: 5),
            NotificationListButton(
              index: 0,
              callback: deleteNotification,
              state: notificationButtonsState,
              activeColor: const Color.fromARGB(255, 253, 118, 118),
              icon: Icons.delete_forever_rounded,
            ),
          ],
        ),
        // Row with text for notification
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NotificationTextContainer(number: "01", text: "день"),
            SizedBox(width: 5),
            NotificationTextContainer(number: "09", text: "годин"),
            SizedBox(width: 5),
            NotificationTextContainer(number: "34", text: "хвилин"),
          ],
        ),
      ],
    );
  }
}
