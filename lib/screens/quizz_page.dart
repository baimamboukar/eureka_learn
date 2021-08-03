import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/models/quizz_model.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizzPage extends StatelessWidget {
  final QuizzModel quizz;
  const QuizzPage({Key? key, required this.quizz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz ${quizz.subject}"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [Question(question: quizz.questions[0])],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.dialog(
                Material(
                  child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Center(child: Text("Lorem ipsum"))),
                ),
              )),
    );
  }
}

class Question extends StatelessWidget {
  final QuestionModel question;
  const Question({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "They were dropping, losing altitude in a canyon of rainbow foliage, a lurid communal mural that completely covered the hull of the spherical chamber. ",
              style: Styles.subtitle),
        ),
        const SizedBox(
          height: 20.0,
        ),
        if (question.image != null) Image.asset("assets/icons/png/biology.png"),
        ...question.options.map((option) => Container(child: Text(option)))
      ],
    ));
  }
}

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
