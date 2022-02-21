import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String label;
  final String subject;
  final String section;
  final String level;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String topic;

  const Question({
    required this.label,
    required this.subject,
    required this.section,
    required this.level,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.topic,
  });

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      label: map['label'],
      subject: map['subject'],
      section: map['section'],
      level: map['level'],
      correctAnswer: map['correct_answer'],
      incorrectAnswers: map['wrong_answers'].split("__")
        ..add(map['correct_answer'] ?? '')
        ..shuffle(),
      topic: map['topic'],
    );
  }

  @override
  List<Object?> get props => [];
}
