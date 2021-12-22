import 'package:eureka_learn/providers/quizz_intro_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class QuizIntro extends HookWidget {
  const QuizIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final difficulty = useProvider(difficultyProvider);
    final numberOfQuestions = useProvider(numberOfQuestionsProvider);
    final quizzTopic = useProvider(quizzTopicProvider);
    final quizzType = useProvider(quizzTypeProvider);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Quizz Intro",
        style: Styles.designText(color: Palette.primary, size: 22, bold: true),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text("Quizz Intro",
                  style: Styles.designText(
                      color: Palette.primary, size: 22, bold: true)),
              Text(
                  "Please give some information about the quizz you want to take",
                  style: Styles.subtitle),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.d_cube_scan),
                  title: Text("Quizz type", style: Styles.subtitle),
                  subtitle: Text("What are you preparing"),
                  trailing: DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: quizzType.state,
                    items: <String>["standard", "exam", "challenge"]
                        .map<DropdownMenuItem<String>>((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type == "standard"
                              ? "$type 💧"
                              : type == "exam"
                                  ? "$type 🔥"
                                  : "$type 🎯",
                          style: Styles.designText(
                              color: Palette.primary, size: 18, bold: true),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? currentValue) {
                      quizzType.state = currentValue!;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.level),
                  title: Text("Quizz difficulty", style: Styles.subtitle),
                  subtitle: Text("Chose your level"),
                  trailing: DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: difficulty.state,
                    items: <String>["novice", "proficient", "expert"]
                        .map<DropdownMenuItem<String>>((String diff) {
                      return DropdownMenuItem<String>(
                        value: diff,
                        child: Text(
                          diff == "novice"
                              ? "$diff 🥉"
                              : diff == "proficient"
                                  ? "$diff 🥈"
                                  : "$diff 🥇",
                          style: Styles.designText(
                              color: Palette.primary, size: 18, bold: true),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? currentValue) {
                      difficulty.state = currentValue!;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.layer),
                  title: Text("Questions amount", style: Styles.subtitle),
                  subtitle: Text("how many questions"),
                  trailing: DropdownButton<int>(
                    underline: const SizedBox.shrink(),
                    value: numberOfQuestions.state,
                    items: <int>[10, 20, 30, 40, 50]
                        .map<DropdownMenuItem<int>>((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(
                          "$number questions",
                          style: Styles.designText(
                              color: Palette.primary, size: 18, bold: true),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? currentValue) {
                      numberOfQuestions.state = currentValue!;
                    },
                  ),
                ),
              ),
              if (quizzType.state != "exam")
                Card(
                  child: ListTile(
                    leading: Icon(Iconsax.layer),
                    title: Text("", style: Styles.subtitle),
                    subtitle: Text("how many questions"),
                    trailing: DropdownButton<int>(
                      underline: const SizedBox.shrink(),
                      value: numberOfQuestions.state,
                      items: <int>[10, 20, 30, 40, 50]
                          .map<DropdownMenuItem<int>>((int number) {
                        return DropdownMenuItem<int>(
                          value: number,
                          child: Text(
                            "$number questions",
                            style: Styles.designText(
                                color: Palette.primary, size: 18, bold: true),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? currentValue) {
                        numberOfQuestions.state = currentValue!;
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Get.to(() => QuizScreen()),
                child: Button(
                    label: "Take quizz",
                    color: Palette.primary,
                    icon: Iconsax.arrow_circle_right),
              )
            ],
          ),
        ),
      ),
    );
  }
}
