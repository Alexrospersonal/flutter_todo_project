import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  static Future<void> onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) async {
    print("Notification tapped");

    // Якщо додаток в фоновому режимі або закритий, відкриється
    // Додайте тут навігацію, якщо потрібно відкрити певний екран
    if (response.payload != null) {
      // Наприклад, можна обробити payload (дані) та виконати навігацію
      // String? payload = response.payload;
      // Виклик навігації або іншої дії
    }
  }

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_laucher");
    const DarwinInitializationSettings iOSinitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSinitializationSettings,
    );

    // Фукнція яка викликається при тапі на сповіщення
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      // Додайте логіку обробки натискання на сповіщення тут
      // print("Tapped on notification");
    },
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platrofmChanelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channel_Id", "channel_Name",
            importance: Importance.high,
            priority: Priority.high,
            autoCancel: true),
        iOS: DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platrofmChanelSpecifics);
  }

  static Future<void> scheduleNotification(int id, 
      String title, String body, DateTime scheduledDate) async {
    const NotificationDetails platrofmChanelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails("channel_Id", "channel_Name",
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        TZDateTime.from(scheduledDate, local), platrofmChanelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  static Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
