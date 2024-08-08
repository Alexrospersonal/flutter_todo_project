import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/date_selector_dialog/notification_widget/notification_list_item_container.dart';

class NotificationSelectorWidget extends StatefulWidget {
  const NotificationSelectorWidget({
    super.key,
  });

  @override
  State<NotificationSelectorWidget> createState() => _NotificationSelectorWidget();
}

class _NotificationSelectorWidget extends State<NotificationSelectorWidget> {

  String firstNotificationText = "Додати";
  IconData firstNotificationIcon = Icons.notification_add;
  List<bool> notificationButtonsState = [false, false, false];

  void changeButtonStatus(int idx) {
    notificationButtonsState[idx] = !notificationButtonsState[idx];

    setState(() {
      if (notificationButtonsState[idx] == false) {
        firstNotificationText = "Додати";
        firstNotificationIcon = Icons.notification_add;
      } else {
        firstNotificationText = "Змінити";
        firstNotificationIcon = Icons.edit_notifications;
      }
    });
  }

  void deleteNotification(int idx) {
    setState(() {
      notificationButtonsState[idx] = false;
      firstNotificationText = "Додати";
    });
  }

  @override
  Widget build(Object context) {
    return const Column(
      children: [
        // Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Створіть нагадування",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
            Text("Нагадати за",
              style: TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        NotifiactionListItemContainer(),
        Divider(
          color: Color.fromRGBO(118, 253, 172, 1),
        ),
      ],
    );
  }
}



