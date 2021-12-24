import 'dart:convert';

import 'package:eureka_learn/models/models.dart';

class Student {
  // ignore: slash_for_doc_comments
  /**
   ------------DATA ATRIBUTES OF STUDENT------------
   */
  String? id;
  final String names;
  final String section;
  final String email;
  final String phone;
  final String? school;
  final String level;
  final String avatar;

  final List<String> achievements;
  final List<QuizzModel> quizzes;
  List<String> subjects;

  final bool prenium;

  Student({
    this.id,
    required this.names,
    required this.section,
    required this.email,
    required this.phone,
    this.school,
    required this.level,
    required this.avatar,
    required this.quizzes,
    required this.achievements,
    required this.subjects,
    required this.prenium,
  });

  Student copyWith({
    String? id,
    String? names,
    String? section,
    String? email,
    String? phone,
    String? school,
    String? level,
    String? avatar,
    List<String>? achievements,
    List<QuizzModel>? quizzes,
    List<String>? subjects,
    bool? prenium,
  }) =>
      Student(
        id: id ?? this.id,
        names: names ?? this.names,
        section: section ?? this.section,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        school: school ?? this.school,
        level: level ?? this.level,
        avatar: avatar ?? this.avatar,
        achievements: achievements ?? this.achievements,
        quizzes: quizzes ?? this.quizzes,
        subjects: subjects ?? this.subjects,
        prenium: prenium ?? this.prenium,
      );

  static Map<String, dynamic> toDocumentSnapshot(Student student) {
    return {
      'id': student.id,
      'names': student.names,
      'section': student.section,
      'email': student.email,
      'phone': student.phone,
      'school': student.school,
      'level': student.level,
      'avatar': student.avatar,
      'achievements': student.achievements,
      'quizzes': student.quizzes,
      'subjects': student.subjects,
      'prenium': student.prenium,
    };
  }

  factory Student.fromDocumentSnapshot(Map<String, dynamic>? map) {
    return Student(
      id: map!['id'],
      names: map['names'],
      section: map['section'],
      email: map['email'],
      phone: map['phone'],
      school: map['school'],
      level: map['level'],
      avatar: map['avatar'],
      achievements: List<String>.from(map['achievements']),
      quizzes: List<QuizzModel>.from(
          map['quizzes'].map((quizz) => QuizzModel.fromMap(quizz))),
      subjects: List<String>.from(map['subjects']),
      prenium: map['prenium'],
    );
  }

  factory Student.initial() {
    return Student(
        names: "Jeanne Doe",
        email: "jeannedoe@eureka-learn.cm",
        phone: "698098787",
        section: "Franco",
        level: "top",
        avatar: "https://zety.com/about/michael-tomaszewski",
        school: "GBHS Garoua",
        subjects: ["Maths", "Physics", "Biology", "Csc"],
        prenium: false,
        quizzes: [],
        achievements: ["Star", "Bronz", "Alpha"]);
  }
  String toJson(Student student) => json.encode(toDocumentSnapshot(student));
  factory Student.fromJson(String source) =>
      Student.fromDocumentSnapshot(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, names: $names, section: $section, email: $email, phone: $phone, school: $school,level: $level, avatar: $avatar, achievements: $achievements, subjects: $subjects, prenium: $prenium)';
  }
}
