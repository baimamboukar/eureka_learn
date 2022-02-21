import 'package:eureka_learn/controllers/quiz_state.dart';
import 'package:eureka_learn/enum/enums.dart';
import 'package:eureka_learn/models/quizz_model.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:eureka_learn/controllers/quiz_controller.dart';
import 'package:eureka_learn/models/failure_model.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/services/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizScreen extends HookWidget {
  final String type;
  final String difficulty;
  final String topic;
  final int numberOfQuestions;

  QuizScreen(
      {required this.type,
      required this.difficulty,
      required this.topic,
      required this.numberOfQuestions});
  @override
  Widget build(BuildContext context) {
    final quizQuestions = useProvider(quizQuestionsProvider);
    final pageController = usePageController();

    return SafeArea(
      child: Scaffold(
        body: quizQuestions.when(
          data: (questions) => _buildBody(context, pageController, questions),
          loading: () => Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                "Loading quiz...",
                style: Styles.subtitle,
              )
            ],
          )),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong!',
          ),
        ),
        bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = useProvider(quizControllerProvider);
            if (!quizState.answered) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.transparent,
                height: 55,
                width: Screen.width(context),
                child: GestureDetector(
                  onTap: () {
                    context
                        .read(quizControllerProvider.notifier)
                        .nextQuestion(questions, pageController.page!.toInt());
                    if (pageController.page!.toInt() + 1 < questions.length) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceOut,
                      );
                    }
                  },
                  child: Center(
                    child: Button(
                      color: Palette.primary,
                      icon: Iconsax.next,
                      label: pageController.page!.toInt() + 1 < questions.length
                          ? 'Next Question'
                          : 'See Results',
                    ),
                  ),
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PageController pageController,
    List<Question> questions,
  ) {
    if (questions.isEmpty) return QuizError(message: 'No questions found.');

    final quizState = useProvider(quizControllerProvider);
    return quizState.status == QuizStatus.complete
        ? QuizResults(state: quizState, questions: questions)
        : QuizQuestions(
            pageController: pageController,
            state: quizState,
            questions: questions,
          );
  }
}

class QuizError extends StatelessWidget {
  final String message;

  const QuizError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.folder_open, size: 100, color: Palette.primary),
          const SizedBox(height: 22),
          Text(message, style: Styles.subtitle),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () => context.refresh(quizRepositoryProvider),
            child: Button(
              label: 'Retry',
              icon: Iconsax.repeat_circle,
              color: Palette.primary,
            ),
          ),
        ],
      ),
    );
  }
}

final List<BoxShadow> boxShadow = const [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4.0,
  ),
];

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.yellow[700],
          gradient: Palette.customGradientWith(
              [Palette.primary, Palette.light, Palette.primary]),
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class QuizResults extends HookWidget {
  final QuizState state;
  final List<Question> questions;

  const QuizResults({
    Key? key,
    required this.state,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String resultMessage;
    Icon resultIcon;
    int correct = state.correct.length;
    if (correct < questions.length * 0.5) {
      resultMessage = "Novice ! Need to practice more";
      resultIcon = Icon(LineIcons.award, color: Colors.brown, size: 100);
    } else if (correct >= questions.length * 0.5 &&
        correct <= questions.length * 0.75) {
      resultMessage = "Proficient! Keep it up";
      resultIcon = Icon(Iconsax.award, color: Colors.grey, size: 100);
    } else {
      resultMessage = "Expert! You are ready for the next level";
      resultIcon = Icon(LineIcons.medal, color: Colors.amberAccent, size: 100);
    }

    final database = useProvider(databaseProvider);
    final user = useProvider(studentControllerProvider.notifier);
    database.addQuizz(
        userID: user.student.id ?? "",
        quizz: QuizzModel(
            subject: useProvider(quizSubjectProvider).state,
            difficulty: useProvider(difficultyProvider).state,
            numberOfQuestions: useProvider(numberOfQuestionsProvider).state,
            correct: state.correct.length,
            date: DateTime.now().toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: Styles.subtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0) + const EdgeInsets.only(top: 20),
          child: Flex(
            direction: Axis.vertical,
            children: [
              const SizedBox(height: 20),
              Text("The results will be added to your profile",
                  style: Styles.subtitle),
              Card(
                child: Container(
                  decoration: BoxDecoration(gradient: Palette.linearGradient),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Text("QUIZZ PERFORMANCES",
                            style: Styles.designText(
                                color: Colors.yellow, size: 18, bold: true)),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Divider(
                            height: 3.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(LineIcons.checkCircleAlt,
                                        color: Colors.yellow),
                                    const SizedBox(width: 4.0),
                                    Text("Subject ➦ ", style: Styles.subtitle),
                                    const SizedBox(width: 4.0),
                                    Text(
                                        context.read(quizSubjectProvider).state,
                                        style: Styles.designText(
                                            bold: true,
                                            color: Palette.light,
                                            size: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(LineIcons.checkCircleAlt,
                                        color: Colors.yellow),
                                    const SizedBox(width: 4.0),
                                    Text("Type ➦ ", style: Styles.subtitle),
                                    const SizedBox(width: 4.0),
                                    Text(context.read(quizzTypeProvider).state,
                                        style: Styles.designText(
                                            bold: true,
                                            color: Palette.light,
                                            size: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(LineIcons.checkCircleAlt,
                                        color: Colors.yellow),
                                    const SizedBox(width: 4.0),
                                    Text("Difficulty ➦ ",
                                        style: Styles.subtitle),
                                    const SizedBox(width: 4.0),
                                    Text(context.read(difficultyProvider).state,
                                        style: Styles.designText(
                                            bold: true,
                                            color: Palette.light,
                                            size: 18)),
                                  ],
                                ),
                              ],
                            ),
                            CircularPercentIndicator(
                                lineWidth: 6.0,
                                percent: ((state.correct.length * 100) /
                                        questions.length) /
                                    100,
                                linearGradient: Palette.customGradientWith(
                                    [Colors.amberAccent, Colors.greenAccent]),
                                header: Text("Score"),
                                center: Text(
                                    "${state.correct.length} / ${questions.length}",
                                    style: Styles.designText(
                                        color: Colors.white,
                                        size: 18,
                                        bold: true)),
                                radius: 60,
                                backgroundColor: Colors.white)
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 4.0),
                          child: Divider(
                            height: 3.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 65,
                              animationDuration: 1500,
                              lineWidth: 8,
                              percent: ((state.incorrect.length * 100) /
                                      questions.length) /
                                  100,
                              backgroundColor: Palette.light,
                              center: Text(((state.incorrect.length * 100) /
                                      questions.length)
                                  .toString()),
                              animation: true,
                              progressColor: Palette.error,
                              footer: Text("incorrect answers"),
                            ),
                            resultIcon,
                            CircularPercentIndicator(
                              radius: 65,
                              lineWidth: 8,
                              animationDuration: 1500,
                              percent: ((state.correct.length * 100) /
                                      questions.length) /
                                  100,
                              backgroundColor: Palette.light,
                              center: Text(((state.correct.length * 100) /
                                      questions.length)
                                  .toString()),
                              animation: true,
                              progressColor: Palette.success,
                              footer: Text("correct answers"),
                            ),
                          ],
                        ),
                        Text(
                          resultMessage,
                          style: Styles.designText(
                              color: Palette.light, size: 18, bold: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SfCircularChart(
              //   backgroundColor: Colors.grey,
              //   legend: Legend(
              //       isVisible: true,
              //       isResponsive: true,
              //       position: LegendPosition.bottom),
              //   title: ChartTitle(text: "Quizz Evaluation"),
              //   series: <CircularSeries>[
              //     DoughnutSeries<String, String>(
              //         legendIconType: LegendIconType.circle,
              //         dataLabelSettings: DataLabelSettings(isVisible: true),
              //         dataSource: ["Correct", "Wrong"],
              //         xValueMapper: (perf, _) => perf,
              //         yValueMapper: (perf, _) => perf == "Correct" ? 7 : 3)
              //   ],
              // ),
              const SizedBox(height: 20.0),
              // Text("Share your accomplishment", style: Styles.subtitle),
              // const SizedBox(height: 12.0),
              // Wrap(
              //   spacing: 10.0,
              //   children: [
              //     Button(
              //         color: Palette.primary,
              //         icon: Iconsax.activity,
              //         label: "Profile"),
              //     Button(
              //         color: Palette.success,
              //         icon: LineIcons.whatSApp,
              //         label: "Whatsapp"),
              //   ],
              // ),
              const SizedBox(height: 50.0),
              GestureDetector(
                onTap: () {
                  context.refresh(quizRepositoryProvider);

                  context.read(quizControllerProvider.notifier).reset();
                },
                child: Button(
                    label: "Retry again",
                    color: Palette.primary,
                    icon: Iconsax.activity),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Perform {
  final String label;
  final int data;
  const Perform({required this.label, required this.data});
}

class QuizQuestions extends StatelessWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions({
    Key? key,
    required this.pageController,
    required this.state,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150.0 + 120,
                width: Screen.width(context),
                child: Column(
                  children: [
                    // LinearPercentIndicator(
                    //   width: Screen.width(context) * .8,
                    //   lineHeight: 14.0,
                    //   percent: ((questions.length *
                    //           (state.correct.length + state.incorrect.length)) /
                    //       100),
                    //   animation: true,
                    //   leading: Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 4.0, right: 4.0, left: 4.0),
                    //     child: CircularCountDownTimer(
                    //       controller: controller,
                    //       isReverse: true,
                    //       isReverseAnimation: true,
                    //       textFormat: CountdownTextFormat.S,
                    //       isTimerTextShown: true,
                    //       width: 50.0,
                    //       height: 50.0,
                    //       strokeWidth: 6.5,
                    //       duration: 20,
                    //       fillColor: Palette.secondary,
                    //       ringColor: Colors.white24,
                    //       onComplete: () {},
                    //     ),
                    //   ),
                    //   center: Text(
                    //       "${((questions.length * (state.correct.length + state.incorrect.length)) / 100).toStringAsFixed(0)} %"),
                    //   backgroundColor: Palette.light,
                    //   progressColor: Palette.success,
                    // ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  color: question.level == "medium"
                                      ? Colors.grey
                                      : question.level == "novice"
                                          ? Colors.brown
                                          : Colors.amber,
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                "${question.level}",
                                style: Styles.designText(
                                    color: Palette.light,
                                    size: 12,
                                    bold: false),
                              ))),
                          Text("Question ${index + 1} of ${questions.length}",
                              style: Styles.subtitle),
                          Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  color: Palette.success,
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                "${state.correct.length}",
                                style: Styles.designText(
                                    color: Palette.light, size: 20, bold: true),
                              ))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 6),
                      child: Text(HtmlCharacterEntities.decode(question.label),
                          style: Styles.designText(
                              color: Palette.light, size: 24, bold: false)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6.0,
                      ),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/eurekalearn-d63d4.appspot.com/o/eureka.png?alt=media&token=9d806524-caa7-4d72-a006-e4ae6e578e0b")),
                          color: Palette.light,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(
                                Screen.width(context) * 0.5, 30),
                            bottomRight: Radius.elliptical(
                                Screen.width(context) * 0.5, 30),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: Palette.customGradientWith([
                    Palette.primary,
                    Palette.primary.withOpacity(.4),
                    Palette.primary
                  ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.elliptical(Screen.width(context) * 0.5, 30),
                    bottomRight:
                        Radius.elliptical(Screen.width(context) * 0.5, 30),
                  ),
                ),
              ),
              Column(
                children: question.incorrectAnswers
                    .map(
                      (e) => AnswerCard(
                        answer: e,
                        isSelected: e == state.selectedAnswer,
                        isCorrect: e == question.correctAnswer,
                        isDisplayingAnswer: state.answered,
                        onTap: () => context
                            .read(quizControllerProvider.notifier)
                            .submitAnswer(question, e),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Iconsax.chart),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: Palette.light,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Text("Questions flow appear here"),
                    ),
                  ));
        },
      ),
    );
  }
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Palette.success
                    : isSelected
                        ? Palette.error
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
