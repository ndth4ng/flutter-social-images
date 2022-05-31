import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  String _message = 'You are not sign in';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

// Sign up
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign in
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign out
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
