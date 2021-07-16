import 'package:eureka_learn/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final valueProvider = StateProvider<String?>((ref) => "Francais");

class Settings extends HookWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = useProvider(darkModeProvider);
    final value = useProvider(valueProvider);
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile.adaptive(
                subtitle: Text("Change Theme Mode"),
                title: Text("Dark mode"),
                value: darkMode.state,
                onChanged: (value) {
                  darkMode.state = value;
                },
              ),
              ListTile(
                title: Text("Language"),
                trailing: DropdownButton<String>(
                  underline: const SizedBox.shrink(),
                  value: value.state,
                  items: <String>["Francais", "English", "Deutsch", "IOS"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Change language",
                  ),
                  onChanged: (String? currentValue) {
                    value.state = currentValue;
                  },
                ),
              ),
            ],
          ),
        )));
  }
}
