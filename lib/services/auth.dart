import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/services/services.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  final Reader _read;
  Authentication(this._firebaseAuth, this._read);

  //track the state of authentication by a real-time listener
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //login user and provide his data to the app once done
  Future<void> loginUser({required String mail, required String pass}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass)
          .then((response) async {
        if (await _read(databaseProvider).getUser(response.user!.uid))
          Fluttertoast.showToast(
              msg: "Successful signed in", backgroundColor: Palette.success);
      });
    } on FirebaseAuthException catch (err) {
      Fluttertoast.showToast(
          msg: err.message ?? "Something went wrong !",
          backgroundColor: Palette.error);
    }
  }

  //sign up the user and store his data to firestore
  Future<void> signupUser(
      {required String mail,
      required String pass,
      required Student student}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass)
          .then((response) async {
        if (await _read(databaseProvider)
            .createUser(id: response.user!.uid, student: student))
          Fluttertoast.showToast(
              msg: "Successful signed up", backgroundColor: Palette.success);
        else
          Fluttertoast.showToast(
              msg: "error while signing up", backgroundColor: Palette.error);
      });
    } on FirebaseAuthException catch (err) {
      Fluttertoast.showToast(
          msg: err.message ?? "Something went wrong !",
          backgroundColor: Palette.error);
    }
  }

  //simply logs out the user
  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut().then((response) => Fluttertoast.showToast(
          msg: "Successful logged out", backgroundColor: Palette.success));
    } on FirebaseAuthException catch (err) {
      Fluttertoast.showToast(
          msg: err.message ?? "Something went wrong !",
          backgroundColor: Palette.error);
    }
  }
}
