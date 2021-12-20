import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/home_screen.dart';
import 'package:eureka_learn/screens/quizz.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/services/services.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft
  ]);
  runApp(ProviderScope(child: Intellilearn()));
}

class Intellilearn extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(darkModeProvider);
    return GetMaterialApp(
      title: "intelli'learn",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade200,
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        iconTheme: IconThemeData(size: 22.0, opacity: 1),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Palette.light,
            elevation: 0.0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.blue),
            actionsIconTheme: IconThemeData(color: Palette.primary),
            iconTheme: IconThemeData(color: Palette.primary, size: 16.0)),
      ),
      darkTheme: ThemeData.dark().copyWith(
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      themeMode: theme.state ? ThemeMode.dark : ThemeMode.light,
      home: Root(),
    );
  }
}

final navigationIndexProvider = StateProvider<int>((ref) => 0);

List<Widget> _screens = [NewsFeed(), Quizz(), Ressources(), HomePage()];
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationIndex = useProvider(navigationIndexProvider);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Iconsax.menu),
                onPressed: () => scaffoldKey.currentState!.openDrawer()),
            title: Logo(
              withIcon: true,
            ),
            actions: [
              IconButton(
                icon: Icon(LineIcons.search),
                onPressed: () => showSearch(
                  context: context,
                  delegate: Search(),
                ),
              ),
              IconButton(
                  icon: Icon(Iconsax.notification),
                  onPressed: () => Get.to(() => Notifications())),
            ]),
        drawer: AppDrawer(),
        body: IndexedStack(
            key: ValueKey<int>(navigationIndex.state),
            index: navigationIndex.state,
            children: _screens.map((screen) => screen).toList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.bubble_chart),
          onPressed: () {
            Get.to(() => Poster());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3.0,
          child: Container(
            height: 52.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(icon: Iconsax.activity, position: 0, label: "Feeds"),
                NavItem(icon: LineIcons.school, position: 1, label: "Quizz"),
                NavItem(
                    icon: Iconsax.reserve, position: 2, label: "Ressources"),
                NavItem(icon: LineIcons.infinity, position: 3, label: "i-Space")
              ],
            ),
          ),
        ));
  }
}
