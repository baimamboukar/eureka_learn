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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      label: json['label'],
      subject: json['subject'],
      section: json['section'],
      level: json['level'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: json['incorrect_answers'],
      topic: json['topic'],
    );
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      label: '',
      subject: '',
      section: '',
      level: '',
      correctAnswer: '',
      incorrectAnswers: [],
      topic: '',
    );
  }

  @override
  List<Object?> get props => [];
}
