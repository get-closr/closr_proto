import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class LoginSignupPage extends StatefulWidget {
//   @override
//   State createState() => _LoginSignupPageState();
// }

// class _LoginSignupPageState extends State<LoginSignupPage> {
//   String _email;
//   String _password;

//   GoogleSignIn googleauth = GoogleSignIn();
//   final formKey = GlobalKey<FormState>();
//   checkFields() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class LoginSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Closr Login/Signup"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Email"),
            Text("Password"),
            Text("Google Sign in")
          ],
        ),
      ),
    );
  }
}
