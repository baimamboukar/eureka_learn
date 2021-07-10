import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Book extends StatelessWidget {
  final String name;
  final String author;
  final String? imagePath;
  final List<String> tags;
  const Book(
      {Key? key,
      required this.name,
      required this.author,
      this.imagePath,
      required this.tags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
                height: 300.0,
                width: 150.0,
                image:
                    AssetImage(imagePath ?? "assets/icons/png/chemestry.png")),
          ),
          Text(
            name,
            style: TextStyle(
                color: Palette.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Text("✍️ $author",
              style: TextStyle(color: Palette.primary.withOpacity(0.5))),
          Wrap(
            spacing: 3.0,
            children: tags
                .map((tag) => Chip(
                      backgroundColor: Palette.primary.withOpacity(0.5),
                      side: BorderSide(
                          color: Palette.primary.withOpacity(0.5), width: 0.60),
                      label: Text(tag),
                    ))
                .toList(),
          ),
          const SizedBox(height: 15.0),
          Center(
              child: Button(
                  label: "Download ♦",
                  color: Palette.success.withOpacity(0.85)))
        ],
      ),
    );
  }
}
