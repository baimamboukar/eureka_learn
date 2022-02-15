import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Ressources extends StatefulHookWidget {
  Ressources({Key? key}) : super(key: key);

  @override
  _RessourcesState createState() => _RessourcesState();
}

class _RessourcesState extends State<Ressources> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: TabBar(
              labelPadding: const EdgeInsets.all(8.0),
              labelColor: Palette.primary,
              unselectedLabelColor: Palette.dark,
              labelStyle: Styles.subtitle,
              tabs: [Text("Papers"), Text("Notes"), Text("Books")],
            ),
          ),
          TabBarView(
            children: [
              PapersExcerpt(papers: papers),
              NotesExcerpt(notes: notes),
              BookStore(),
            ],
          )
        ],
      )),
    );
  }
}
