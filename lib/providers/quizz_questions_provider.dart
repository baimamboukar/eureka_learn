import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/services/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final  quizQuestionsProvider =
    FutureProvider.autoDispose<List<Question>>(
  (ref) => ref.watch(quizRepositoryProvider).getQuestions(
      student: ref.watch(studentControllerProvider.notifier).student,
      level: "medium",
      subject: ref.watch(quizSubjectProvider).state,
      numQuestions: 4),
);

final questionsProvider = FutureProvider.autoDispose<List<Question>>((ref) =>
    ref.watch(databaseProvider).getQuestions(
        numberOfQuestions: ref.watch(numberOfQuestionsProvider).state,
        subject: ref.watch(quizSubjectProvider).state,
        difficulty: ref.watch(difficultyProvider).state,
        type: ref.watch(quizzTypeProvider).state));
