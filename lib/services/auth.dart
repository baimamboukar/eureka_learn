import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  void loginUser({required String mail, required String pass}) {
    try {
      _firebaseAuth.signInWithEmailAndPassword(email: mail, password: pass);
    } on FirebaseAuthException catch (err) {
      print(err.message);
    }
  }

  void signupUser() {
    print("lorem son");
  }
}
