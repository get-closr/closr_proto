import 'package:flutter/material.dart';
import 'ui/pages/login_signup_page.dart';

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLOSR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupPage(),
      routes: <String, WidgetBuilder>{
        "/loginsignuppage": (BuildContext context) => LoginSignupPage(),
      },
    );
  }
}
