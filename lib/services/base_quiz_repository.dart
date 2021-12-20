import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/enum/difficulty.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions({
    required Student student,
    int? numQuestions,
    required String subject,
  });
}
