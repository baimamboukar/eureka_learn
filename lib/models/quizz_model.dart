import 'dart:convert';

class QuizzModel {
  final String subject;
  final String difficulty;
  final String? type;
  final String? topic;
  final int numberOfQuestions;
  final int correct;
  final String date;

  QuizzModel(
      {required this.subject,
      this.topic,
      required this.difficulty,
      this.type,
      required this.numberOfQuestions,
      required this.correct,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'difficulty': difficulty,
      'type': type,
      'topic': topic,
      'numberOfQuestions': numberOfQuestions,
      'correct': correct,
      'date': date,
    };
  }

  factory QuizzModel.fromMap(Map<String, dynamic> map) {
    return QuizzModel(
      subject: map['subject'] ?? '',
      difficulty: map['difficulty'] ?? '',
      type: map['type'],
      topic: map['topic'],
      numberOfQuestions: map['numberOfQuestions']?.toInt() ?? 0,
      correct: map['correct']?.toInt() ?? 0,
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizzModel.fromJson(String source) =>
      QuizzModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuizzModel(subject: $subject, difficulty: $difficulty, type: $type, topic: $topic, numberOfQuestions: $numberOfQuestions, correct: $correct, date: $date)';
  }
}
