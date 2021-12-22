import 'package:eureka_learn/providers/quizz_intro_providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 250),
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
                  title: Text("Quizz Type", style: Styles.subtitle),
                  subtitle: Text("choose your level"),
                  trailing: DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: quizzType.state,
                    items: <String>["standard", "exam", "challenge"]
                        .map<DropdownMenuItem<String>>((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(color: Palette.dark),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Choose your level...",
                    ),
                    onChanged: (String? currentValue) {
                      quizzType.state = currentValue!;
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.d_cube_scan),
                  title: Text("Quizz difficulty", style: Styles.subtitle),
                  subtitle: Text("choose your level"),
                  trailing: DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: difficulty.state,
                    items: <String>["novice", "proficient", "expert"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Palette.dark),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Choose your level...",
                    ),
                    onChanged: (String? currentValue) {
                      difficulty.state = currentValue!;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
