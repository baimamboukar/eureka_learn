import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationService {
  // ignore: unused_field
  final Reader _read;
  NotificationService(this._read);
  final _notiff = AwesomeNotifications();

  void init() {
    _notiff.initialize(null, [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Palette.primary,
          ledColor: Colors.white)
    ]);
  }

  void send(
      {required String title,
      required String body,
      required String summary,
      required String channel,
      String? callback,
      String? icon}) {
    _notiff.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
      init();
      _notiff.createNotification(
          content: NotificationContent(
            id: Random().nextInt(100000),
            channelKey: channel,
            title: title,
            body: body,
            bigPicture:
                'https://tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg',
            notificationLayout: NotificationLayout.BigPicture,
          ),
          actionButtons: [
            NotificationActionButton(
                buttonType: ActionButtonType.InputField,
                label: "Comment",
                key: "alpha")
          ]);
    });
  }
}

final notificationsProvider =
    Provider<NotificationService>((ref) => NotificationService(ref.read));
