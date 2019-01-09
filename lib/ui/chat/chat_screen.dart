import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Firebaseanimatedlist"),
          Divider(
            height: 1.0,
          ),
          Container(child: Text('Text composer')),
        ],
      ),
    );
  }
}
