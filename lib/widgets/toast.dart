import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Toast {
  static toast(
      {required Color color,
      required String title,
      required String message,
      required IconData icon}) {
    Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 5),
        icon: Icon(LineIcons.checkCircle),
        message: message,
        backgroundColor: color,
        title: title,
        showProgressIndicator: true,
        dismissDirection: DismissDirection.horizontal));
  }
}
