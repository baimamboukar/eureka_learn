import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  // with StreamProvider we listen to these changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(
      {required String email, required String password}) async {
    print(_firebaseAuth);
    try {
      print("inside try block");
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("after await....");
      print(response);
      return 'Signed in';
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    print("le massacre du sign in");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("done well");
      return 'Signed up ';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
