import 'package:eureka_learn/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DrawerItem extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Widget? destination;
  const DrawerItem({Key? key, this.icon, required this.label, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Get.to(() => destination ?? FlutterLogo()),
        leading: icon,
        title: Text(label, style: Styles.subtitle),
        trailing: Icon(LineIcons.angleRight));
  }
}
