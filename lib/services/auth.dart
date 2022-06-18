import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Stream<User?> get firebaseUser {
    return _auth.authStateChanges().map((User? firebaseUser) => firebaseUser);
  }

// Sign up
  Future signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (result.user != null) {
        _addUser(result.user!, username);
      }

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

  Future<void> _addUser(User user, String username) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users.doc(user.uid).set({
      'uid': user.uid,
      'username': username,
      'email': user.email,
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> checkUsername(String username) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.get();
    final listUsers = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (dynamic user in listUsers) {
      if (user['username'] == username) {
        return true;
      }
    }

    return false;
  }
}
