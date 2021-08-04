import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/models/quizz_model.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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
          child: Icon(Icons.dashboard),
          onPressed: () => Get.dialog(
                Material(
                  child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Center(child: Text("Echo test 1234"))),
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
          padding: const EdgeInsets.all(20.0),
          child: Text(
              "They were dropping, losing altitude in a canyon of rainbow foliage, a lurid communal mural that completely covered the hull of the spherical chamber. ",
              style: Styles.subtitle),
        ),
        const SizedBox(
          height: 20.0,
        ),
        if (question.image != null) Image.asset("assets/icons/png/biology.png"),
        ...question.options.map((option) => Option(option: option)),
      ],
    ));
  }
}

class Option extends StatefulWidget {
  final String option;
  const Option({Key? key, required this.option}) : super(key: key);

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  final colored = false;
  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      delay: Duration(milliseconds: 1000),
      duration: Duration(milliseconds: 1000),
      child: GestureDetector(
        //  onTap: () => setState(() => colored = true),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            ),
            child: SizedBox(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.option, style: Styles.subtitle),
                    Icon(LineIcons.checkCircleAlt, color: Palette.success)
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
