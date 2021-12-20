import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eureka_learn/models/failure_model.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/models/question_model.dart';
import 'package:eureka_learn/services/base_quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRepository {
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions({
    required Student student,
    int? numQuestions = 4,
    required String subject,
  }) async {
    try {
      final response = await _read(dioProvider).get(
          'https://intelliquizz.herokuapp.com/$subject/${student.level}/$numQuestions',
          onReceiveProgress: (x, y) {});

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data["results"] ?? []);
        if (results.isNotEmpty) {
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );
    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}
