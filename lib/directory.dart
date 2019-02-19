import 'package:flutter/material.dart';
import 'package:closr/models/pages.dart';
import 'package:closr/ui/pages/home.dart';
import 'package:closr/ui/components/red.dart';
import 'package:closr/ui/components/yellow.dart';
import 'ui/pages/no_content.dart';
import 'ui/widgets/chat.dart';
import 'package:closr/utils/auth.dart';

class Directory extends StatelessWidget {
  final Pages page;
  final Auth auth;
  const Directory({this.page, this.auth});
  @override
  Widget build(BuildContext context) {
    // print(page);
    switch (page) {
      case Pages.home:
        return Home();
        break;
      case Pages.chat:
        return ChatScreen(auth: auth);
        break;
      case Pages.profile:
        return Red();
        break;
      case Pages.settings:
        return Yellow();
        break;
      default:
        return NoContent();
    }
  }
}
