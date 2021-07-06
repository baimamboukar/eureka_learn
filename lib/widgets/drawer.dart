import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/screens/login.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FlipInY(
            child: Container(
                child: ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(gradient: Palette.linearGradient),
          margin: null,
          accountEmail: Text("eureka.learn@admin.cm"),
          accountName: Text("Alpha admin"),
        ),
        for (var item in items..shuffle()) item
      ],
    ))));
  }
}

List<DrawerItem> items = [
  DrawerItem(
      icon: Icon(LineIcons.themeco),
      label: "Settings",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.themeco),
      label: "Profile",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.medal),
      label: "Challenges",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.star), label: "Rate us", destination: FlutterLogo()),
];

class DrawerItem extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Widget? destination;
  const DrawerItem({Key? key, this.icon, required this.label, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Get.to(() => destination),
        leading: icon,
        title: Text(label),
        trailing: Icon(LineIcons.angleRight));
  }
}
