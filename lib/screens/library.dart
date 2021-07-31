import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class Library extends StatefulHookWidget {
  Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

List<PaperModel> _papers = [
  PaperModel(
      from: "GBHSM",
      subject: "Physics",
      since: DateTime.parse("2021-05-28"),
      type: "2nd Sequence"),
  PaperModel(
      from: "Lykama",
      subject: "Csc",
      since: DateTime.parse("2028-04-18"),
      type: "4th Sequence"),
  PaperModel(
      from: "Xv Vogt",
      subject: "Philosophy",
      since: DateTime.parse("2021-05-28"),
      type: "Mock Exam"),
  PaperModel(
      from: "CMGHSM",
      subject: "Information Systems",
      since: DateTime.parse("2021-05-28"),
      type: "4th Sequence"),
  PaperModel(
      from: "OBC",
      subject: "Economics",
      since: DateTime.parse("2021-05-28"),
      type: "2022 Exam"),
];

class _LibraryState extends State<Library> {
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
              Ressources(papers: _papers),
              NotesExcerpt(notes: _notes),
              BookView(),
            ],
          )
        ],
      )),
    );
  }
}

class Ressources extends StatelessWidget {
  final List<PaperModel> papers;
  const Ressources({Key? key, required this.papers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0) + const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            for (int x = 0; x < 10; x++)
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(top: 15.0),
                  title: Text("Maths", style: Styles.subtitle),
                  leading: Image.asset(x % 3 == 0
                      ? "assets/icons/png/maths.png"
                      : "assets/icons/png/geography.png"),
                  childrenPadding: const EdgeInsets.all(14.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trending papers", style: Styles.subtitle),
                        Icon(LineIcons.starAlt, color: Palette.primary)
                      ],
                    ),
                    Text("Most downloaded papers"),
                    const SizedBox(height: 30.0),
                    for (int i = 0; i < papers.length; i++)
                      Paper(model: papers[i]),
                    Divider(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            Text(
                                "Bei den Initiativen im Bereich der Risikovorsorge liegt der Schwerpunkt auf einer Stärkung des Bankensystems gegenüber",
                                style: Styles.subtitle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("120 lessons"),
                                GestureDetector(
                                  onTap: () => Get.to(() => ExplorePapers(
                                        classe: "1ere",
                                        subject: "Maths",
                                      )),
                                  child: Chip(
                                      visualDensity:
                                          VisualDensity.adaptivePlatformDensity,
                                      elevation: 8.0,
                                      backgroundColor:
                                          Palette.primary.withOpacity(0.5),
                                      side: BorderSide(
                                          color:
                                              Palette.primary.withOpacity(0.85),
                                          width: 1.0),
                                      label: Row(
                                        children: [
                                          Text("Explore..",
                                              style: Styles.subtitle),
                                          Icon(LineIcons.angleRight,
                                              color: Palette.dark)
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

List<Note> _notes = [
  Note(subject: "Maths", topics: [
    Topic(
        title: "Arithmetic in Z",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Biology", topics: [
    Topic(
        title: "Genetics and human legacy",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Computer science", topics: [
    Topic(
        title: "Basic Data structures",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Physics", topics: [
    Topic(
        title: "Harmonic Oscillators",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ]),
    Topic(
        title: "Newton Laws",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ]),
    Topic(
        title: "Differential Equations",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "Geography", topics: [
    Topic(
        title: "Volcanism",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
  Note(subject: "CitizenShip Education", topics: [
    Topic(
        title: "Arithmetic in Z",
        intro:
            "We think that most co-branded splash pages use far too much XSL, and not enough Java. Without development, you will lack affiliate-based compliance. ",
        content: [
          "And until such enumeration shall be held in the State from which he fled, be delivered up, to be removed from Office on Impeachment for, and Conviction of,."
        ])
  ]),
];

class NotesExcerpt extends StatelessWidget {
  final List<Note> notes;
  const NotesExcerpt({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < notes.length; i++)
              Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.only(top: 15.0),
                    title: Text(notes[i].subject, style: Styles.subtitle),
                    leading: Image.asset("assets/icons/png/geography.png"),
                    childrenPadding: const EdgeInsets.all(14.0),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...notes[i].topics.map((topic) => GestureDetector(
                            onTap: () =>
                                Get.to(() => TopicDetails(topic: topic)),
                            child: Align(
                              heightFactor: 0.65,
                              child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  color: Palette.randomColor(),
                                  child: ListTile(
                                    title: Text(topic.title),
                                    trailing: Icon(LineIcons.angleRight),
                                  )),
                            ),
                          ))
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
