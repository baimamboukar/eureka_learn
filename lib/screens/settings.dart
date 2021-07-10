import 'package:eureka_learn/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Settings extends HookWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = useProvider(darkModeProvider);
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SwitchListTile.adaptive(
              title: Text("Dark mode"),
              value: darkMode.state,
              onChanged: (value) {
                darkMode.state = value;
              },
            )
          ],
        )));
  }
}
