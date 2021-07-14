import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/login.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/palette.dart';
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

GlobalKey _scaffoldKey = GlobalKey();
final navigationIndexProvider = StateProvider<int>((ref) => 0);
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

List<Widget> _screens = [
  All(),
  Logo(withIcon: true),
  Library(),
  Logo(withIcon: true)
];

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationIndex = useProvider(navigationIndexProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(LineIcons.tasks),
              onPressed: () => Scaffold.of(context).openDrawer),
          title: Logo(
            withIcon: true,
          ),
          actions: [
            IconButton(
              icon: Icon(LineIcons.search),
              onPressed: () => print("we move"),
            ),
            IconButton(
              icon: Icon(LineIcons.bell),
              onPressed: () => print("we move"),
            ),
          ]),
      drawer: AppDrawer(),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 100),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: IndexedStack(
              key: ValueKey<int>(navigationIndex.state),
              index: navigationIndex.state,
              children: _screens),
        ),
        child: IndexedStack(
            key: ValueKey<int>(navigationIndex.state),
            index: navigationIndex.state,
            children: _screens),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex.state,
        onTap: (index) {
          navigationIndex.state = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(LineIcons.fire),
              label: "Trending",
              tooltip: "news and feed"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.medal),
              label: "Quizz",
              tooltip: "Evaluate yourself"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.bookOfTheDead),
              label: "Library",
              tooltip: "Thousand of ressources at your disposal"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.userFriends),
              label: "Classes",
              tooltip: "learn and grow together"),
        ],
      ),
    );
  }d
}

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authStateProvider);
    return user.when(
        data: (currentUser) {
          if (currentUser != null) {
            return Home();
          } else {
            return Login();
          }
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stackTree) => Text("lol"));
  }
}
