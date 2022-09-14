/* 
  ✨✨✨ SNAG SPEED BUSINESS ✨✨✨
  
⛳ AUTHOR: BAIMAM BOUKAR JJ
⛳ CONTACTS: baimamboukar@gmail.com | (+237)690535759

🎯 BRIEF ==> This file contains an dart extension to the `BuildContext`.
It simplifies how you can access to the app router [AUTOROUTE]

⚽ USAGE ==> use context.autorouter.[AUTO_ROUTE_METHOD] instead of AutoRoute.of(context)!.[AUTO_ROUTE_METHOD]
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' show BuildContext;

extension Router on BuildContext {
  StackRouter get autorouter => AutoRouter.of(this);
}
