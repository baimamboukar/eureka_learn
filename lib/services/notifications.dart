import 'package:flutter/material.dart' show Widget;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final Reader _read;

  static final FlutterLocalNotificationsPlugin notif =
      FlutterLocalNotificationsPlugin();
  NotificationService(this._read);

  static const details = NotificationDetails(
      android: AndroidNotificationDetails(
          "8113", "test", "sending random notifications for test",
          importance: Importance.max, priority: Priority.max));

  static init() async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const ios = IOSInitializationSettings();
    await notif.initialize(InitializationSettings(android: android, iOS: ios),
        onSelectNotification: (payload) {
      print("lorem ipsum dolor si amet");
      return Future.value(5);
    });
  }

  Future send(
          {required int id,
          required String title,
          required String message,
          required String payload,
          required Widget callbackWidget}) async =>
      await notif.show(id, title, message, details);

  hacktitude(String message, Duration after) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    notif.periodicallyShow(
        10,
        "Hacktitude of the day",
        "A winner is a dreamer who never gives up",
        RepeatInterval.everyMinute,
        details);
    notif.zonedSchedule(
        0,
        'scheduled title',
        message,
        tz.TZDateTime.now(tz.local).add(after),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}

final notificationsProvider = Provider<NotificationService>((ref) {
  NotificationService.init();
  return NotificationService(ref.read);
});
