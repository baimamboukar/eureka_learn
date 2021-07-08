import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(child: Logo(withIcon: true)),
        )
      ],
    ));
  }
}
