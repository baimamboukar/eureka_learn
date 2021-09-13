import 'package:flutter/material.dart' show Widget;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  final Reader _read;

  static final FlutterLocalNotificationsPlugin notif =
      FlutterLocalNotificationsPlugin();
  NotificationService(this._read);

  static const details = NotificationDetails(
      android: AndroidNotificationDetails(
          "8113", "test", "sending random notifications for test",
          priority: Priority.max));

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

  static schedule(String message, Duration after) {}
}

final notificationsProvider = Provider<NotificationService>((ref) {
  NotificationService.init();
  return NotificationService(ref.read);
});
