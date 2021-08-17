import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/models/quizz_model.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final choiceEventProvider = StateProvider<bool>((ref) => false);
final selectedOptionProvider = StateProvider<String?>((ref) => "");
final currentQuestionProvider = StateProvider<int>((ref) => 0);

class QuizzPage extends HookWidget {
  final QuizzModel quizz;
  const QuizzPage({Key? key, required this.quizz}) : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    final currentQuestion = useProvider(currentQuestionProvider);
    final choiceMade = useProvider(choiceEventProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz ${quizz.subject}"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text("Question ${currentQuestion.state + 1}",
                style: Styles.subtitle),
          ),
          Question(question: quizz.questions[0]),
          if (choiceMade.state)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                onTap: () {
                  choiceMade.state = false;
                  currentQuestion.state = currentQuestion.state + 1;
                },
                child: FlipInY(
                  duration: Duration(milliseconds: 750),
                  child: Button(
                      color: Palette.primary,
                      icon: currentQuestion.state == quizz.questions.length
                          ? LineIcons.signature
                          : LineIcons.mapPin,
                      label: currentQuestion.state == quizz.questions.length
                          ? "View results..."
                          : "Continue"),
                ),
              ),
            )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.dashboard),
          onPressed: () => Get.dialog(
                Material(child: QuestionsGrid()),
              )),
    );
  }
}

class Question extends StatelessWidget {
  final QuestionModel question;

  const Question({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
       ♦ Adding the correct answer to the list of questions
       ♦ Shuffling them so that the answer should not be fixed as last item
     * 
     */
    question.options
      ..add(question.answer)
      ..shuffle();

    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
          child: Text(
              "They were dropping, losing altitude in a canyon of rainbow foliage, a lurid communal mural that completely covered the hull of the spherical chamber. ",
              style: Styles.subtitle),
        ),
        const SizedBox(
          height: 8.0,
        ),
        if (question.image != null)
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
            child: Image.asset(
              "assets/icons/png/biology.png",
              height: 80.0,
            ),
          ),
        ...question.options.map((option) => Option(option: option)),
      ],
    ));
  }
}

class Option extends HookWidget {
  final String option;

  Option({required this.option});
  @override
  Widget build(BuildContext context) {
    final choiceMade = useProvider(choiceEventProvider);
    final selectedOption = useProvider(selectedOptionProvider);
    return SlideInLeft(
      delay: Duration(milliseconds: 1000),
      duration: Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: () {
          if (choiceMade.state == false) choiceMade.state = !choiceMade.state;
          if (selectedOption.state == option)
            selectedOption.state = "";
          else
            selectedOption.state = option;
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Card(
            color: choiceMade.state && selectedOption.state == option
                ? Palette.primary.withOpacity(0.35)
                : Palette.light,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),
                side: choiceMade.state && selectedOption.state == option
                    ? BorderSide(color: Palette.primary, width: 1.50)
                    : BorderSide.none),
            child: SizedBox(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(option, style: Styles.subtitle),
                    choiceMade.state && selectedOption.state == option
                        ? FlipInX(
                            duration: Duration(milliseconds: 1000),
                            child: Icon(LineIcons.checkCircle,
                                color: Palette.light))
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionsGrid extends StatelessWidget {
  const QuestionsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            child: GridView.builder(
      semanticChildCount: 12,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 50.0,
            width: 50.0,
            color: Palette.primary,
            child: Center(child: Text(index.toString())));
      },
    )));
  }
}
