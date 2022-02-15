import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Root extends StatefulHookWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(authStateProvider);
    final database = useProvider(databaseProvider);
    getUser(user) async {
      await database.getUser(user);
    }

    return user.when(
        loading: () => Scaffold(body: Loading()),
        error: (_, __) => Text("Something went wrong"),
        data: (authenticatedUser) {
          if (authenticatedUser != null) {
            getUser(authenticatedUser.uid);
            setState(() {});
            //Navigator.pop(context);
            return Home();
          } else {
            return Welcome();
          }
        });
  }
}
