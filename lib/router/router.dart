/* 
  ✨✨✨ SNAG SPEED BUSINESS ✨✨✨
  
⛳ AUTHORS: {
  🔖 BAIMAM BOUKAR JJ,
}
⛳ CONTACTS: {
  🔖 baimamboukar@gmail.com | (+237)690535759,
}

🔥 TYPE: CONFIGS
🎯 BRIEF ==> {
  💡 This file contains all the routes of screens used in this project
  💡 The default routing package is AUTO_ROUTE
  💡 Some routes have guards, like the home route
  💡 The `@AdaptiveAutoRouter` generates a file `router.g.dart` in the same directory. This file contains generated dart code ease navigation

  💡 RUN THIS ANY TIME YOU ADD A ROUTE IN THIS FILE: `flutter packages pub run build_runner build`
  💡 OR YOU CAN RUN THIS UST ONCE: `flutter packages pub run build_runner watch --delete-conflicting-outputs`
}
}

*/
import 'package:auto_route/auto_route.dart';
import 'package:eurekalearn/screens/screens.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Home, initial: true),
    AutoRoute(page: Login),
  ],
)
class $AppRouter {}
