import 'package:flutter/material.dart';
import 'package:closr/models/pages.dart';
import 'package:closr/ui/components/home.dart';
import 'package:closr/ui/components/red.dart';
import 'package:closr/ui/components/yellow.dart';
import 'ui/pages/no_content.dart';
import 'ui/widgets/chat.dart';

class Directory extends StatelessWidget {
  final Pages page;
  const Directory({this.page});
  @override
  Widget build(BuildContext context) {
    // print(page);
    switch (page) {
      case Pages.home:
        return Home();
        break;
      case Pages.chat:
        return ChatScreen();
        break;
      case Pages.profile:
        return Red();
        break;
      case Pages.settings:
        return Yellow();
        break;
      case Pages.logout:
      //TODO: Raise dialog
      default:
        return NoContent();
    }
  }
}
