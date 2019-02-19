import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<String> googleLogIn();

  Future<void> signOut();

  // Future<Null> _ensureLoggedIn();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> googleLogIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    print(checkUserExist(user));
    // storeNewUser(user);
    return user.uid;
  }

  // Future<Null> _ensureLoggedIn() async {}

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print(user);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(user);
    print(checkUserExist(user));
    storeNewUser(user); //if user does not already exist
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    try {
      return _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkUserExist(user) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('/users')
        .where('email', isEqualTo: user.email)
        .where('uid', isEqualTo: user.uid)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length > 0;
  }

  void storeNewUser(user) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
    }); //TODO: Many new fields to add!
  }
}
