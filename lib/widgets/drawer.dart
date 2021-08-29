import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/controllers/controllers.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/models/quizz_model.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/quizz_page.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class AppDrawer extends HookWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = useProvider(authProvider);
    final _student = useProvider(studentControllerProvider.notifier);
    return Drawer(
        child: FlipInY(
            child: Container(
                child: ListView(
      children: [
        UserAccountsDrawerHeader(
            otherAccountsPictures: [
              Logo(withIcon: true),
            ],
            decoration: BoxDecoration(gradient: Palette.linearGradient),
            margin: null,
            accountEmail: Text(_student.student.email),
            accountName: Text("")),
        for (var item in items) item,
        ListTile(
            onTap: () => _auth.logoutUser(),
            title: Text("Logout"),
            leading: Icon(LineIcons.signature),
            trailing: Icon(LineIcons.angleRight)),
      ],
    ))));
  }
}
