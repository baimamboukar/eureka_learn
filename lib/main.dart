import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: EurekaLearn()));
}

class EurekaLearn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "EurekaLearn",
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          primaryColorDark: Colors.black,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212239),
          accentColor: Colors.white,
          dividerColor: Colors.black12,
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
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
        appBar: AppBar(),
        drawer: AppDrawer(),
        body: Center(child: Text("Eureka Learn lorem ipsum dolor si amet")));
  }
}
