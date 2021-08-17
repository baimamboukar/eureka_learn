import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/controllers/user_controller.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Reader _read;
  Database(this._read);

  Future<bool> createUser(
      {required String id, required Student student}) async {
    try {
      await _firestore.collection("students").doc(id).set({
        'id': student.id,
        'names': student.names,
        'section': student.section,
        'email': student.email,
        'phone': student.phone,
        'school': student.school,
        'level': student.level,
        'avatar': student.avatar,
        'achievements': student.achievements,
        'subjects': student.subjects,
        'prenium': student.prenium,
        'birthdate': student.birthdate,
      }).then((response) => true);
      return true;
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
          msg: "Error while creating user: ${err.message}..");
      return false;
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      await _firestore.collection('students').doc(uid).get().then((doc) {
        Student _student = Student.fromDocumentSnapshot(doc.data());
        _read(studentControllerProvider.notifier).student = _student;
      });
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong ${err.message}",
        backgroundColor: Palette.error,
      );
      return "Something went wrong";
    }
  }
}
