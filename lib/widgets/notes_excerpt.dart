import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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
            ...subjectsBox.map((subject) {
              final List<Note> _notes = List.from(
                  notes.where((note) => note.subject == subject.subject));
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 6.0),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.only(top: 15.0),
                      title: Text(subject.subject ?? "Subject",
                          style: Styles.subtitle),
                      leading: Image.asset(subject.imagePath ??
                          "assets/icons/png/geography.png"),
                      childrenPadding: const EdgeInsets.all(14.0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._notes.map((note) {
                          return Column(
                            children: [
                              ...note.topics.map((topic) => GestureDetector(
                                    onTap: () => Get.to(
                                        () => TopicDetails(topic: topic)),
                                    child: Align(
                                      heightFactor: 0.65,
                                      child: Card(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          color: Palette.randomColor(),
                                          child: ListTile(
                                            title: Text(topic.title),
                                            trailing:
                                                Icon(LineIcons.angleRight),
                                          )),
                                    ),
                                  )),
                            ],
                          );
                        })
                      ],
                    ),
                  ));
            })
          ],
        ),
      ),
    );
  }
}
