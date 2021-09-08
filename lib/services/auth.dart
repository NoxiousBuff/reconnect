import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth auth;
  Authentication(this.auth);

  Stream get authChanges => auth.idTokenChanges();

  signUp({String userName, String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.setPersistence(Persistence.LOCAL);
      print('User: $email logged in successfully.');
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
