import 'dart:convert';

class Student {
  // ignore: slash_for_doc_comments
  /**
   ------------DATA ATRIBUTES OF STUDENT------------
   */
  final String id;
  final String names;
  final String section;
  final String email;
  final String phone;
  final String school;
  final String town;
  final String level;
  final String avatar;

  final List<String> achievements;
  List<String> subjects;

  final bool prenium;

  final DateTime birthdate;

  Student({
    required this.id,
    required this.names,
    required this.section,
    required this.email,
    required this.phone,
    required this.school,
    required this.town,
    required this.level,
    required this.avatar,
    required this.achievements,
    required this.subjects,
    required this.prenium,
    required this.birthdate,
  });

  Student copyWith({
    String? id,
    String? names,
    String? section,
    String? email,
    String? phone,
    String? school,
    String? town,
    String? level,
    String? avatar,
    List<String>? achievements,
    List<String>? subjects,
    bool? prenium,
    DateTime? birthdate,
  }) =>
      Student(
        id: id ?? this.id,
        names: names ?? this.names,
        section: section ?? this.section,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        school: school ?? this.school,
        town: town ?? this.town,
        level: level ?? this.level,
        avatar: avatar ?? this.avatar,
        achievements: achievements ?? this.achievements,
        subjects: subjects ?? this.subjects,
        prenium: prenium ?? this.prenium,
        birthdate: birthdate ?? this.birthdate,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'names': names,
      'section': section,
      'email': email,
      'phone': phone,
      'school': school,
      'town': town,
      'level': level,
      'avatar': avatar,
      'achievements': achievements,
      'subjects': subjects,
      'prenium': prenium,
      'birthdate': birthdate.millisecondsSinceEpoch,
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
      town: map['town'],
      level: map['level'],
      avatar: map['avatar'],
      achievements: List<String>.from(map['achievements']),
      subjects: List<String>.from(map['subjects']),
      prenium: map['prenium'],
      birthdate: DateTime.fromMillisecondsSinceEpoch(map['birthdate']),
    );
  }

  String toJson() => json.encode(toMap());
  factory Student.fromJson(String source) =>
      Student.fromDocumentSnapshot(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, names: $names, section: $section, email: $email, phone: $phone, school: $school, town: $town, level: $level, avatar: $avatar, achievements: $achievements, subjects: $subjects, prenium: $prenium, birthdate: $birthdate)';
  }
}
