import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
              iconTheme: IconThemeData(color: Palette.primary, size: 16.0)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Palette.light,
            elevation: 3.0,
            selectedItemColor: Palette.primary,
            unselectedItemColor: Palette.dark.withOpacity(0.33),
            showUnselectedLabels: true,
            selectedIconTheme:
                IconThemeData(color: Palette.primary, size: 22.0),
            unselectedIconTheme: IconThemeData(color: Colors.grey, size: 18.0),
            selectedLabelStyle:
                TextStyle(color: Palette.primary, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          )),
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
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationIndex = useProvider(navigationIndexProvider);

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
        body: Scaffold(
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 1200),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: IndexedStack(
                key: ValueKey<int>(navigationIndex.state),
                index: navigationIndex.state,
                children: [Logo()],
              ),
            ),
            child: IndexedStack(
              key: ValueKey<int>(navigationIndex.state),
              index: navigationIndex.state,
              children: [
                Scaffold(body: Center(child: Logo())),
                Scaffold(body: Center(child: Logo())),
                Scaffold(body: Center(child: Logo())),
                Scaffold(body: Center(child: Logo()))
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationIndex.state,
            onTap: (index) {
              navigationIndex.state = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Text("📚"), label: "Home", tooltip: "news and feed"),
              BottomNavigationBarItem(
                  icon: Text("🔥"),
                  label: "Questions",
                  tooltip: "news and feed"),
              BottomNavigationBarItem(
                  icon: Text("📚"), label: "Quizz", tooltip: "news and feed"),
              BottomNavigationBarItem(
                  icon: Text("🔥"), label: "Grow", tooltip: "news and feed"),
            ],
          ),
        ));
  }
}
