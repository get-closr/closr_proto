import 'package:flutter/material.dart';
import 'package:closr/utils/auth.dart';
import 'package:closr/backdrop.dart';
import 'package:closr/models/pages.dart';
import 'package:closr/ui/pages/menu_page.dart';
import 'package:closr/directory.dart';

class ClosrMain extends StatefulWidget {
  ClosrMain({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => _ClosrMainState();
}

class _ClosrMainState extends State<ClosrMain> {
  Pages _currentPage = Pages.home;

  void _onPageTap(Pages page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Backdrop(
          currentPage: Pages.home,
          frontLayer: Directory(page: _currentPage, auth: widget.auth),
          backLayer: MenuPage(
            currentPage: _currentPage,
            onPagesTap: _onPageTap,
          ),
          frontTitle: Text("CLOSR"),
          backTitle: Text("MENU"),
          auth: widget.auth,
          onSignedOut: widget.onSignedOut),
    );
  }
}
