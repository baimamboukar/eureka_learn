import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  final FirebaseFirestore _firestore;
  Database(this._firestore);

  Future<bool> createUser(Student student) async {
    try {
      await _firestore.collection('students').doc(student.id).set({
        'id': student.id,
        'names': student.names,
        'section': student.section,
        'email': student.email,
        'phone': student.phone,
        'school': student.school,
        'town': student.town,
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
      DocumentSnapshot doc =
          await _firestore.collection('students').doc(uid).get();
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong ${err.message}",
        backgroundColor: Palette.error,
      );
      return "Something went wrong";
    }
  }
}
