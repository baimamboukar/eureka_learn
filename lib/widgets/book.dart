import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BookDetails extends StatelessWidget {
  final BookModel model;
  const BookDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding:
              const EdgeInsets.all(14.0) + const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                      height: 200.0,
                      width: 180.0,
                      image: AssetImage(
                          model.imagePath ?? "assets/icons/png/chemestry.png")),
                ),
                Text(
                  model.name,
                  style: TextStyle(
                      color: Palette.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                    "They shall in all Cases, except Treason, Felony and Breach of the President and Vice President, declaring what Officer shall act accordingly, until the next Meeting of the State from which he shall have been presented to him. ",
                    style: Styles.subtitle),
                Text("✍️ ${model.author}",
                    style: TextStyle(color: Palette.primary.withOpacity(0.5))),
                Wrap(
                  spacing: 3.0,
                  children: model.tags!
                      .map((tag) => Chip(
                            backgroundColor: Palette.primary.withOpacity(0.5),
                            side: BorderSide(
                                color: Palette.primary.withOpacity(0.5),
                                width: 0.60),
                            label: Text(tag),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 15.0),
                Center(
                    child: Button(
                        label: "Download",
                        icon: LineIcons.download,
                        color: Palette.success.withOpacity(0.85)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
