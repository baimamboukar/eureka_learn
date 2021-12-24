import 'package:animate_do/animate_do.dart';

import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class AppDrawer extends HookWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = useProvider(authProvider).state;
    final student = useProvider(studentControllerProvider.notifier);
    return Drawer(
        child: FlipInY(
            child: Container(
                child: Flex(
      direction: Axis.vertical,
      children: [
        UserAccountsDrawerHeader(
            otherAccountsPictures: [
              CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      OptimizedCacheImageProvider(student.student.avatar))
            ],
            decoration: BoxDecoration(gradient: Palette.linearGradient),
            margin: null,
            currentAccountPictureSize: Size(200, 150),
            accountEmail: Text(student.student.email),
            accountName: Text(student.student.names, style: Styles.subtitle)),
        DrawerItem(
            icon: Icon(Iconsax.user_octagon, color: Palette.primary),
            label: "Profile",
            destination: Profile(user: student.student)),
        for (var item in items) item,
        ListTile(
            onTap: () => _auth.logoutUser(),
            title: Text("Logout"),
            leading: Icon(LineIcons.signature),
            trailing: Icon(LineIcons.angleRight)),
        Expanded(
            child: Column(
          children: [Logo(withIcon: false)],
        ))
      ],
    ))));
  }
}

List<dynamic> items = [
  DrawerItem(
      icon: Icon(Iconsax.setting, color: Palette.primary),
      label: "Settings",
      destination: Settings()),
  DrawerItem(
      icon: Icon(Iconsax.save_2, color: Palette.primary),
      label: "Saved",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(Iconsax.message_question, color: Palette.primary),
      label: "FAQs",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.identificationBadge, color: Palette.primary),
      label: "Authentication",
      destination: Welcome()),
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
        onTap: () => Get.to(() => destination ?? FlutterLogo()),
        leading: icon,
        title: Text(label, style: Styles.subtitle),
        trailing: Icon(LineIcons.angleRight));
  }
}
