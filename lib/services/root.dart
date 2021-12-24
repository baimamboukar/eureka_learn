import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authStateProvider);
    final database = watch(databaseProvider);
    return user.when(
        loading: () => Scaffold(body: Loading()),
        error: (_, __) => Text("Something went wrong"),
        data: (authenticatedUser) {
          if (authenticatedUser != null) {
            database.getUser(authenticatedUser.uid);
            //database.getUserFeeds();
            return Home();
          } else {
            return Welcome();
          }
        });
  }
}
