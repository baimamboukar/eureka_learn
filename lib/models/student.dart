import 'package:firebase_auth/firebase_auth.dart';

class Student {
  // ignore: slash_for_doc_comments
  /**
   ------------DATA ATRIBUTES OF STUDENT------------
   */
  final String names;
  final String section;
  final String email;
  final String phone;
  final String school;
  final String town;
  final String level;

  final List<String> achievements;
  List<String> subjects;

  final bool prenium;

  final DateTime brithdate;

  Student(
      this.names,
      this.section,
      this.email,
      this.phone,
      this.school,
      this.town,
      this.level,
      this.prenium,
      this.brithdate,
      this.achievements,
      this.subjects);
}
