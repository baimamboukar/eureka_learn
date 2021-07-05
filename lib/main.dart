import 'dart:ffi';

import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
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
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
          iconTheme: IconThemeData(size: 16.0, opacity: 0.85),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              color: Palette.light,
              elevation: 0.0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.blue),
              actionsIconTheme: IconThemeData(color: Palette.primary),
              textTheme: GoogleFonts.josefinSansTextTheme(),
              iconTheme: IconThemeData(color: Palette.primary, size: 16.0))),
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

GlobalKey _scaffoldKey = GlobalKey();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(LineIcons.tasks), onPressed: () => print("move")),
            title: Logo(),
            actions: [
              IconButton(
                icon: Icon(LineIcons.bell),
                onPressed: () => print("we move"),
              ),
            ]),
        drawer: AppDrawer(),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
                height: Screen.height(context) * 0.25,
                decoration: BoxDecoration(
                    //gradient: Palette.linearGradient,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(text: "Hi, ", children: [
                              TextSpan(
                                  text: "Zarathustra",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ]))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 4.0),
                      child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          maxLength: 1000,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.primary, width: 1),
                                  borderRadius: BorderRadius.circular(20.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.primary, width: 0.50),
                                  borderRadius: BorderRadius.circular(20.0)),
                              prefix: Text("✍️"),
                              filled: true,
                              fillColor: Colors.grey.shade200)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          ActionButton(
                              label: "add file",
                              icon: Text("🖇️"),
                              callback: () => print("exporting...")),
                          const SizedBox(width: 10.0),
                          ActionButton(
                              label: "add photo",
                              icon: Icon(LineIcons.photoVideo),
                              callback: () => print("exporting..."))
                        ],
                      ),
                    )
                  ],
                )),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Browsing by categories..."),
          )),
          SliverToBoxAdapter(
            child: Container(
                height: 55.0,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        subjects.map((label) => Label(model: label)).toList())),
          ),
          SliverToBoxAdapter(
              child: IndexedStack(
            children: [
              Container(
                  width: Screen.width(context),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 120.0,
                        ),
                        Logo(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text("Let's go 🧗🏻",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]))
            ],
          ))
        ]));
  }
}

List<LabelModel> subjects = [
  LabelModel(title: "All", iconPath: "🔥", active: false),
  LabelModel(title: "Chemestry", iconPath: "🌡️", active: false),
  LabelModel(title: "Geography", iconPath: "🌍", active: false),
  LabelModel(title: "Biology", iconPath: "🔬", active: false),
  LabelModel(title: "Maths", iconPath: "📈", active: false),
  LabelModel(title: "Csc", iconPath: "💻", active: false),
  LabelModel(title: "Physics", iconPath: "🚀", active: false),
  LabelModel(title: "Philosophy", iconPath: "📚", active: false),
];
