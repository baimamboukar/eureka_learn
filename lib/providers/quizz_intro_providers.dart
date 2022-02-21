import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizzTypeProvider = StateProvider<String>((ref) => "standard");
final difficultyProvider = StateProvider<String>((ref) => "medium");
final numberOfQuestionsProvider = StateProvider<int>((ref) => 10);
final quizzTopicProvider = StateProvider<String>((ref) => "novice");
