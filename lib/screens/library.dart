import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Library extends StatefulHookWidget {
  Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  Widget build(BuildContext context) {
    final activeIndex = useProvider(activeIndexProvider);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Menu(),
            height: 50.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IndexedStack(
              index: activeIndex.state,
              children: [
                BookView(),
                Ressources(),
                Center(
                  child: Logo(
                    withIcon: true,
                  ),
                ),
                Center(
                  child: Logo(
                    withIcon: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class Ressources extends StatelessWidget {
  const Ressources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0) + const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          ExpansionTile(
            title: Text("Maths", style: Styles.subtitle),
            leading: Image.asset("assets/icons/png/maths.png"),
            childrenPadding: const EdgeInsets.all(14.0),
            children: [
              for (int i = 0; i < 10; i++) Paper(),
            ],
          )
        ],
      ),
    );
  }
}
