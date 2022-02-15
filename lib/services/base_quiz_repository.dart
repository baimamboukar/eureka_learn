import 'package:eureka_learn/models/models.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions({
    required Student student,
    int? numQuestions,
    required String subject,
  });
}
