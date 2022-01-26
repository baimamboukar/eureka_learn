import 'package:bot_toast/bot_toast.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          BotToast.showText(text: "Successful signed up");
      });
    } on FirebaseAuthException catch (err) {
      BotToast.showText(text: "Successful signed up ${err.message}");
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
        student.id = response.user!.uid;
        if (await _read(databaseProvider)
            .createUser(id: response.user!.uid, student: student)) {
          BotToast.showText(text: "Successful signed up");
        } else
          BotToast.showText(text: "Something went wrong !");
      });
    } on FirebaseAuthException catch (err) {
      // handle different firebase exceptions
      BotToast.showText(text: "Errrrrrror up");
    }
  }

  //simply logs out the user
  Future<void> logoutUser() async {
    try {
      await _firebaseAuth
          .signOut()
          .then((response) => BotToast.showText(text: "Successful signed out"));
    } on FirebaseAuthException catch (err) {
      BotToast.showText(text: "Successful signed up ${err.message}");
    }
  }
}
