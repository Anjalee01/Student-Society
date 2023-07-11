import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('logo');

  void initializeNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max, priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  void scheduleNotification(String title, String body, String time) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max, priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    if (time == "minute") {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
          0, title, body, RepeatInterval.everyMinute, notificationDetails);
    } else if (time == "hour") {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
          0, title, body, RepeatInterval.hourly, notificationDetails);
    } else if (time == "Daily") {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
          0, title, body, RepeatInterval.daily, notificationDetails);
    } else if (time == "Weekly") {
      await _flutterLocalNotificationsPlugin.periodicallyShow(
          0, title, body, RepeatInterval.weekly, notificationDetails);
    }
  }

  void stopNotification() async {
    _flutterLocalNotificationsPlugin.cancel(0);
  }
}
