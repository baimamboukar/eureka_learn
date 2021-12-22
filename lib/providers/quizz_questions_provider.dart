import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/services/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final AutoDisposeFutureProvider<List<Question>>? quizQuestionsProvider =
    FutureProvider.autoDispose<List<Question>>(
  (ref) => ref.watch(quizRepositoryProvider).getQuestions(
      student: ref.read(studentControllerProvider.notifier).student,
      subject: ref.read(quizSubjectProvider).state,
      numQuestions: 4),
);

final questionsProvider = FutureProvider((ref) => ref
    .read(databaseProvider)
    .getQuestions(
        numberOfQuestions: 3,
        subject: "Biology",
        difficulty: "medium",
        type: "exam"));
