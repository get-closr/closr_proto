import 'package:flutter/material.dart';
import 'package:CLOSR/utils/auth.dart';
import 'package:CLOSR/ui/chat/chat_screen.dart';

class Closrhome extends StatefulWidget {
  Closrhome({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => _ClosrhomeState();
}

class _ClosrhomeState extends State<Closrhome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLOSR"),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, semanticLabel: 'menu'),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              semanticLabel: 'settings',
            ),
            onPressed: () {
              print('settings button');
            },
          ),
          FlatButton(
            child: Text(
              'LOGOUT',
            ),
            onPressed: _signOut,
          )
        ],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          profileSection,
          Divider(
            height: 1.0,
          ),
          photoSection,
          Divider(
            height: 1.0,
          ),
          ChatScreen(),
        ],
      ),
    );
  }

  Widget photoSection = Container(
    height: 400,
    color: Colors.pinkAccent[100],
  );

  Widget profileSection = Container(
    height: 100,
    color: Colors.grey[50],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('Name Lala'), Text('My descriptions')],
        ),
        CircleAvatar(
          radius: 40,
          child: Image.asset('asset/images/dev.png'),
        ),
      ],
    ),
  );

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
