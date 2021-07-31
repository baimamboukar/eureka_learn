import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/login.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ProviderScope(child: EurekaLearn()));
}

class EurekaLearn extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(darkModeProvider);
    return GetMaterialApp(
      title: "EurekaLearn",
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          primaryColorDark: Colors.black,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
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
          backgroundColor: const Color(0xFF1C1C27),
          accentColor: Colors.white,
          dividerColor: Colors.black12,
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      themeMode: theme.state ? ThemeMode.dark : ThemeMode.light,
      home: Root(),
    );
  }
}

final navigationIndexProvider = StateProvider<int>((ref) => 0);
List<LabelModel> subjects = [
  LabelModel(title: "All", iconPath: "🔥", active: false),
  LabelModel(title: "Chemistry", iconPath: "🌡️", active: false),
  LabelModel(title: "Geo", iconPath: "🌍", active: false),
  LabelModel(title: "Biology", iconPath: "🔬", active: false),
  LabelModel(title: "Maths", iconPath: "📈", active: false),
  LabelModel(title: "Csc", iconPath: "💻", active: false),
  LabelModel(title: "Physics", iconPath: "🚀", active: false),
  LabelModel(title: "Philosophy", iconPath: "📚", active: false),
];

List<Widget> _screens = [All(), Quizz(), Library(), Logo(withIcon: true)];
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
                      )),
              Badge(
                badgeContent: Text("12"),
                position: BadgePosition.topEnd(top: 7.5, end: 5),
                child: IconButton(
                    icon: Icon(LineIcons.bell),
                    onPressed: () => Get.to(() => Notifications())),
              ),
            ]),
        drawer: AppDrawer(),
        body: IndexedStack(
            key: ValueKey<int>(navigationIndex.state),
            index: navigationIndex.state,
            children: _screens.map((screen) => FadeIn(child: screen)).toList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(LineIcons.podcast),
          onPressed: () {
            Fluttertoast.showToast(
                msg: "Interact with millions of students",
                backgroundColor: Palette.success);
            Get.dialog(
              Scaffold(body: FlipInY(child: Center(child: Poster()))),
            );
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

class Root extends HookWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(authStateProvider);

    return user.when(
        loading: () => Scaffold(body: CircularProgressIndicator()),
        error: (_, __) => Text("Something went wrong"),
        data: (authenticatedUser) =>
            authenticatedUser != null ? Home() : Login());
  }
}

class NavItem extends HookWidget {
  final IconData icon;
  final int position;
  final String label;
  const NavItem({
    Key? key,
    required this.icon,
    required this.position,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = useProvider(navigationIndexProvider);
    return GestureDetector(
      onTap: () => index.state = position,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              position == index.state
                  ? Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          color: Palette.primary, shape: BoxShape.circle))
                  : SizedBox.shrink(),
              // Badge(
              //   badgeContent: Center(child: Text("8")),
              //   stackFit: StackFit.passthrough,
              //   padding: const EdgeInsets.all(3.0),
              //   position: BadgePosition.topEnd(top: 0, end: -7.50),
              Icon(icon,
                  color: position == index.state
                      ? Palette.primary
                      : Palette.primary.withOpacity(0.5)),
              // ),
              Text(label,
                  style: TextStyle(
                      color: position == index.state
                          ? Palette.primary
                          : Palette.primary.withOpacity(0.5),
                      fontWeight: position == index.state
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
