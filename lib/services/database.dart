import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/controllers/user_controller.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final Reader _read;
  Database(this._read);

  //=====*****USER AUTHENTICATION*****=====//
  Future<bool> createUser(
      {required String id, required Student student}) async {
    try {
      _firestore.collection('students').doc(id).set({
        'id': id,
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
      }).then((_) async {
        getUser(id);
      });

      return true;
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
          msg: "Error while creating user: ${err.message}..");
      return false;
    }
  }

  bool getUser(String uid) {
    try {
      _firestore
          .collection('students')
          .doc(uid)
          .get(GetOptions(source: Source.serverAndCache))
          .then((doc) {
        Student _student = Student.fromDocumentSnapshot(doc.data());
        _read(studentControllerProvider.notifier).data = _student;
      });
      return true;
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong ${err.message}",
        backgroundColor: Palette.error,
      );
      return false;
    }
  }

  //=====*****END USER AUTH*****=====//

//=======****POSTS****================//

  bool post(PostModel post) {
    try {
      _firestore
          .collection('posts')
          .doc()
          .set(PostModel.toDocumentSnapshot(post))
          .then((posted) {
        Fluttertoast.showToast(
          msg: "Successful posted",
          backgroundColor: Palette.success,
        );
      });

      return true;
    } on FirebaseException catch (err) {
      Fluttertoast.showToast(
        msg: "Something went wrong ${err.message}",
        backgroundColor: Palette.error,
      );
      return false;
    }
  }

  //======*****END POST*****======//

  // String uploadMedia(File media, String path) {
  //   storage.ref().child(path).putFile(media).then((response){
  //     response.
  //   });
  // }

  Stream getUserPapers(Student user) {
    try {
      Stream papers = _firestore
          .collection("papers")
          .where("level", isEqualTo: user.level)
          .snapshots();
      return papers;
    } on FirebaseException catch (_) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Error while getting papers",
          backgroundColor: Palette.error);
      rethrow;
    }
  }

  Stream getUserFeed(Student user) {
    try {
      return _firestore
          .collection("posts")
          .where("ownerLevel", isEqualTo: user.level)
          .where("tags", arrayContainsAny: user.subjects)
          .orderBy("timeAgo")
          .snapshots();
    } on FirebaseException catch (_) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Error while getting papers",
          backgroundColor: Palette.error);
      rethrow;
    }
  }

  Stream getUserBooks(Student user) {
    try {
      Stream papers = _firestore
          .collection("books")
          .where("subject", whereIn: user.subjects)
          .where("tags", arrayContainsAny: user.subjects)
          .where("tags", arrayContainsAny: user.achievements)
          .snapshots();
      return papers;
    } on FirebaseException catch (_) {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Error while getting papers",
          backgroundColor: Palette.error);
      rethrow;
    }
  }
}
