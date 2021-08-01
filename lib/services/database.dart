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
        "name": student.names,
        "phone": student.phone,
        "email": student.email,
        "avatar": student.avatar,
        "level": student.level,
        "achievements": student.achievements,
      });
      return true;
    } on FirebaseException catch (err) {
      print(err.message);
      return false;
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('students').doc(uid).get();
      return Student.fromDocumentSnapshot(doc);
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong ${err.message}",
        backgroundColor: Palette.error,
      );
      return "Something went wrong";
    }
  }
}
