import 'package:eureka_learn/models/question_model.dart';

enum QuizzState{
  initial,
  ongoing,
  finished,
}

class QuizzModel {
  final List<QuestionModel> questions;
  final String subject;
  final String topic;
  final bool? timed;
  final QuizzState state;
  final bool isGeneralQuizz;

  QuizzModel(
      {required this.questions,
      required this.subject,
      required this.topic,
      this.timed,
      required this.isGeneralQuizz})
      : assert(questions.length % 5 == 0);
}
