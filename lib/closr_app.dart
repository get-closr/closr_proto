import 'package:flutter/material.dart';
import 'ui/pages/root_page.dart';
import 'utils/auth.dart';
import 'ui/theme/theme.dart';

class ClosrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Closr App',
      home: RootPage(
        auth: Auth(),
      ),
      // initialRoute: '/login',
      // onGenerateRoute: _getRoute,
      theme: buildClosrTheme(1),
    );
  }
}
