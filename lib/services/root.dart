import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Root extends HookWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(authStateProvider);
    return user.when(
        loading: () => Scaffold(body: Loading()),
        error: (_, __) => Text("Something went wrong"),
        data: (authenticatedUser) =>
            authenticatedUser != null ? Home() : Welcome());
  }
}
