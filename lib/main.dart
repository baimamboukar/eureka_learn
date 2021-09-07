import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/services/services.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
  runApp(ProviderScope(child: EurekaLearn()));
}

class EurekaLearn extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(darkModeProvider);
    return GetMaterialApp(
      title: "EurekaLearn",
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColorBrightness: Brightness.light,
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
            textTheme: GoogleFonts.josefinSansTextTheme(),
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

List<Widget> _screens = [
  NewsFeed(),
  Quizz(),
  Ressources(),
  Logo(
    withIcon: true,
  )
];
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationIndex = useProvider(navigationIndexProvider);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(LineIcons.tasks),
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
                  icon: Icon(LineIcons.bell),
                  onPressed: () => Get.to(() => Notifications())),
            ]),
        drawer: AppDrawer(),
        body: IndexedStack(
            key: ValueKey<int>(navigationIndex.state),
            index: navigationIndex.state,
            children: _screens.map((screen) => FadeIn(child: screen)).toList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.bubble_chart),
          onPressed: () {
            Get.dialog(
                Material(
                    child: Container(
                        height: 400.0,
                        width: double.infinity,
                        child: FadeOut(child: Center(child: Poster())))),
                useRootNavigator: false);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavItem(icon: LineIcons.globe, position: 0, label: "Home"),
                NavItem(icon: LineIcons.school, position: 1, label: "Quizz"),
                NavItem(
                    icon: LineIcons.bookReader,
                    position: 2,
                    label: "Ressources"),
                NavItem(
                    icon: LineIcons.userFriends, position: 3, label: "Forum")
              ],
            ),
          ),
        ));
  }
}
