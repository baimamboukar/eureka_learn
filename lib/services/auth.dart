import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<String?> loginUser(
      {required String mail, required String pass}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: mail, password: pass);
      return "You are signed in";
    } on FirebaseAuthException catch (err) {
      print(err.message);
      return err.message;
    }
  }

  Future<String?> signupUser(
      {required String mail, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      return "You are signed in";
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  Future<String?> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }
}
