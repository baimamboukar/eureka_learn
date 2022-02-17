import 'package:eureka_learn/models/paper_model.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final valueProvider = StateProvider<String?>((ref) => "Paper");

class Paper extends HookWidget {
  final PaperModel model;
  const Paper({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = useProvider(valueProvider);
    return GestureDetector(
      onTap: () {
        Get.to(() => PaperView(
              paper: model,
            ));
      },
      child: Align(
          heightFactor: 0.65,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      24.0,
                    ),
                    topRight: Radius.circular(24.0)),
                side: BorderSide(color: Palette.primary, width: 1.50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                  leading: Image.asset("assets/icons/png/pdf.svg",
                      height: 50, width: 50, fit: BoxFit.cover),
                  title: Text("${model.type}",
                      overflow: TextOverflow.ellipsis,
                      style: Styles.designText(
                          bold: true,
                          size: 16.0,
                          color: Palette.primary.withOpacity(0.75))),
                  subtitle: Text(
                    "${model.from}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  trailing: DropdownButton<String>(
                    icon: Icon(LineIcons.download),
                    underline: const SizedBox.shrink(),
                    items: <String>[
                      "Paper",
                      "Answer",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(LineIcons.download),
                            Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Download",
                    ),
                    onChanged: (String? currentValue) {
                      value.state = currentValue;
                    },
                  ),
                ),
              ))),
    );
  }
}
