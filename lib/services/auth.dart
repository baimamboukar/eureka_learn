import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  //track the state of authentication by a real-time listener
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //login user and provide his data to the app once done
  Future<void> loginUser({required String mail, required String pass}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass)
          .then((response) => Fluttertoast.showToast(
              msg: "Successful signd in", backgroundColor: Palette.success));
    } on FirebaseAuthException catch (err) {
      Fluttertoast.showToast(
          msg: err.message ?? "Something went wrong !",
          backgroundColor: Palette.error);
    }
  }

  //sign up the user and store his data to firestore
  Future<void> signupUser({required String mail, required String pass}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass)
          .then((response) {
        Fluttertoast.showToast(
            msg: "Successful signed up", backgroundColor: Palette.success);
      });
      Get.toEnd(() => Home());
    } on FirebaseAuthException catch (err) {
      Fluttertoast.showToast(
          msg: err.message ?? "Something went wrong !",
          backgroundColor: Palette.error);
    }
  }

  //simpli logs out the user
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
