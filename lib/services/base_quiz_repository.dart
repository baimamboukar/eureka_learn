import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/enum/difficulty.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions({
    int? numQuestions,
    String? section,
    String? level,
    String? subject,
  });
}
