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
        ListTile(
            onTap: () => Get.to(() => Login()),
            leading: Icon(LineIcons.userShield),
            title: Text("Authentication"),
            trailing: Icon(LineIcons.angleRight))
      ],
    ))));
  }
}
