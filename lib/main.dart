import 'package:eureka_learn/services/services.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: EurekaLearn()));
}

class EurekaLearn extends StatelessWidget {
  final mode;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "EurekaLearn",
      themeMode: isdark() ? ThemeMode.dark : ThemeMode.system,
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          primaryColorDark: Colors.black,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212239),
        accentColor: Colors.white,
        dividerColor: Colors.black12,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        body: Center(
            child: FutureBuilder<bool>(
                future: Storage.getDarkmode(),
                builder: (context, mode) => Switch(
                    value: mode.data ?? false,
                    onChanged: (value) => Storage.setDarkmode(value)))));
  }
}
