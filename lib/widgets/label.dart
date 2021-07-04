import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';

class Label extends StatefulWidget {
  final LabelModel model;
  const Label({Key? key, required this.model}) : super(key: key);

  @override
  _LabelState createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => widget.model.active = !widget.model.active),
        child: AnimatedContainer(
            curve: Curves.easeInCubic,
            width: 85.0,
            height: 20.0,
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(
                color: widget.model.active ? null : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.0),
                gradient: widget.model.active ? Palette.linearGradient : null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.model.iconPath,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Text(widget.model.title)
              ],
            )),
      ),
    );
  }
}

class LabelModel {
  final String title;
  final String iconPath;
  bool active;

  LabelModel(
      {required this.title, required this.iconPath, required this.active});
}
