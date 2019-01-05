import 'package:flutter/material.dart';
import 'package:CLOSR/utils/auth.dart';

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
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
