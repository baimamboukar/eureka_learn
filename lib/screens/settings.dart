import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

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
              Card(
                child: SwitchListTile.adaptive(
                  secondary: CircleAvatar(child: Icon(LineIcons.lightningBolt)),
                  subtitle: Text("Change Theme Mode"),
                  title: Text("Dark mode", style: Styles.subtitle),
                  value: darkMode.state,
                  onChanged: (value) {
                    darkMode.state = value;
                  },
                ),
              ),
              Card(
                child: SwitchListTile.adaptive(
                  secondary: CircleAvatar(child: Icon(LineIcons.bellAlt)),
                  subtitle: Text("Want to receive notifications ?"),
                  title: Text("Notifications", style: Styles.subtitle),
                  value: darkMode.state,
                  onChanged: (value) {
                    darkMode.state = value;
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(LineIcons.globe)),
                  title: Text("Language", style: Styles.subtitle),
                  subtitle: Text("change language"),
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
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.share)),
                  title: Text("Share", style: Styles.subtitle),
                  subtitle: Text("invite a friend"),
                  trailing: Icon(LineIcons.share),
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                      child: Icon(LineIcons.heartbeat, color: Palette.error)),
                  title: Text("Rate us", style: Styles.subtitle),
                  subtitle: Text("rate the app"),
                  trailing: Icon(
                    LineIcons.heartbeat,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(LineIcons.questionCircle)),
                  title: Text("FAQs", style: Styles.subtitle),
                  subtitle: Text("confused about something?"),
                  trailing: Icon(
                    LineIcons.angleRight,
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
