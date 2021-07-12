import 'dart:html';

import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Settings extends HookWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = useProvider(darkModeProvider);
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                tileColor: Palette.primary.withOpacity(0.5),
                subtitle: Text("Change Theme Mode"),
                title: Text("Dark mode"),
                value: darkMode.state,
                onChanged: (value) {
                  darkMode.state = value;
                },
              ),
              ListTile(title: Text("Language"), trailing: Icon(LineIcons.globe))
            ],
          ),
        )));
  }
}
