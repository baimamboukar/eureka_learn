import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/home_screen.dart';
import 'package:eureka_learn/screens/quizz.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/services/services.dart';
import 'package:eureka_learn/utils/app_theme.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';

import 'services/local/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft
  ]);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        criticalAlerts: true,
        channelShowBadge: true,
        playSound: true,
        channelKey: 'posts',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Palette.primary,
        ledColor: Colors.white)
  ]);
  if (Platform.isIOS) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          showWhen: true,
          fullScreenIntent: true,
          category: NotificationCategory.Social,
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
          ticker: "Post alert",
          id: 123412,
          channelKey: 'posts',
          title: message.notification?.title ?? 'No title',
          body: message.notification?.body ?? 'No message',
          bigPicture: message.notification?.android?.imageUrl ?? '',
          notificationLayout: NotificationLayout.BigPicture,
        ),
        actionButtons: [
          NotificationActionButton(
              buttonType: ActionButtonType.InputField,
              key: "FCM_NOTIFF",
              label: "Let's see"),
          NotificationActionButton(
              buttonType: ActionButtonType.Default, label: "Like", key: "beta")
        ]);
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  });

  AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    print(receivedNotification.payload);
  });
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: Intellilearn()));
}

class Intellilearn extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final _appThemeState = watch(appThemeStateProvider.notifier);

    return GetMaterialApp(
      title: "intelli'learn",
      darkTheme: ThemeData.dark().copyWith(
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      theme: context
          .read(appThemeProvider)
          .getAppThemedata(context, _appThemeState.isDarkModeEnabled)
          .copyWith(
            textTheme:
                GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
          ),
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
