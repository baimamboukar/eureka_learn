import 'dart:math';

import 'package:awesome_notifications/android_foreground_service.dart';
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
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Public,
          criticalAlerts: true,
          channelShowBadge: true,
          playSound: true,
          channelKey: 'posts',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Palette.primary,
          ledColor: Colors.white),
      NotificationChannel(
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Public,
          criticalAlerts: true,
          channelShowBadge: true,
          playSound: true,
          channelKey: 'hacktitudes',
          channelName: 'Sending daily hacktitudes to students',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Palette.primary,
          ledColor: Colors.white),
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
            showWhen: true,
            fullScreenIntent: true,
            category: NotificationCategory.Social,
            wakeUpScreen: true,
            displayOnBackground: true,
            displayOnForeground: true,
            ticker: "tick",
            id: Random().nextInt(100000),
            channelKey: channel,
            title: title,
            body: body,
            bigPicture:
                'https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/eureka.png?alt=media&token=9d806524-caa7-4d72-a006-e4ae6e578e0b',
            notificationLayout: NotificationLayout.BigPicture,
          ),
          actionButtons: [
            NotificationActionButton(
                buttonType: ActionButtonType.InputField,
                label: "Comment",
                key: "alpha"),
            NotificationActionButton(
                buttonType: ActionButtonType.Default,
                label: "Like",
                key: "beta")
          ]).then((response) async {});
    });
  }

  static void foreGround() {
    AndroidForegroundService.startForeground(
        content: NotificationContent(
            id: 2341234,
            body: 'Service is running!',
            title: 'Android Foreground Service',
            channelKey: 'basic_channel',
            bigPicture:
                'https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/eureka.png?alt=media&token=9d806524-caa7-4d72-a006-e4ae6e578e0b',
            notificationLayout: NotificationLayout.BigPicture,
            category: NotificationCategory.Service),
        actionButtons: [
          NotificationActionButton(
              key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
        ]);
  }
}

final notificationsProvider =
    Provider<NotificationService>((ref) => NotificationService(ref.read));
