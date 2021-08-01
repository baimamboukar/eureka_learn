import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Student(
      {required this.id,
      required this.names,
      required this.section,
      required this.email,
      required this.phone,
      required this.school,
      required this.town,
      required this.level,
      required this.prenium,
      required this.birthdate,
      required this.achievements,
      required this.subjects,
      required this.avatar});

  static Student fromDocumentSnapshot(DocumentSnapshot doc) {
    Student user = Student(
      id: doc["id"],
      names: doc["names"],
      section: doc["section"],
      email: doc["email"],
      phone: doc["phone"],
      school: doc["school"],
      town: doc["town"],
      level: doc["level"],
      prenium: doc["prenium"],
      birthdate: doc["names"],
      achievements: doc["achievements"],
      subjects: doc["subjects"],
      avatar: doc["avatar"],
    );

    return user;
  }
}
