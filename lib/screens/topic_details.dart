import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TopicDetails extends StatelessWidget {
  final Topic topic;
  const TopicDetails({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Palette.primary.withOpacity(0.25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0) +
                  const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(topic.intro,
                  style: Styles.subtitle.copyWith(fontStyle: FontStyle.italic)),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => print("saving..."), child: Icon(LineIcons.bookmark)),
    );
  }
}
