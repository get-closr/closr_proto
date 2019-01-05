import 'package:flutter/material.dart';
import 'ui/pages/root_page.dart';
import 'utils/auth.dart';

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Closr Login',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: Auth()));
  }
}
