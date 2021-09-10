import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FlutterLocalNotificationsPlugin notif = FlutterLocalNotificationsPlugin();

class NotificationService {
  final Reader _read;

  NotificationService(this._read);
  static send(String message) {}
  static schedule(String message, Duration after) {}
}
