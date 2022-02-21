import 'package:eureka_learn/models/models.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions(
      {required Student student,
      int? numQuestions = 10,
      required String subject,
      required String level,
      String? topic});
}
