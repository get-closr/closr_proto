import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:closr/utils/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

const String _name = "Your Name";
var currentUserEmail;
var _scaffoldContext;

@override
class ChatMessageListItem extends StatelessWidget {
  final DataSnapshot messageSnapshot;
  final Animation animation;

  ChatMessageListItem({this.messageSnapshot, this.animation});

  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: currentUserEmail == messageSnapshot.value['email']
              ? getSentMessageLayout()
              : getReceivedMessageLayout(),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(messageSnapshot.value['senderName']),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: messageSnapshot.value['imageUrl'] != null
                  ? Image.network(
                      messageSnapshot.value['imageUrl'],
                      width: 250.0,
                    )
                  : Text(messageSnapshot.value['text']),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(messageSnapshot.value['senderPhotoUrl']),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(messageSnapshot.value['senderPhotoUrl']),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(messageSnapshot.value['senderName']),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: messageSnapshot.value['imageUrl'] != null
                      ? Image.network(messageSnapshot.value['imageUrl'],
                          width: 250.0)
                      : Text(messageSnapshot.value['text']),
                ),
              ],
            ),
          )
        ],
      )
    ];
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({this.auth});

  final Auth auth;
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  final reference = FirebaseDatabase.instance.reference().child('messages');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              query: reference,
              reverse: true,
              sort: (a, b) => b.key.compareTo(a.key),
              itemBuilder: (_, DataSnapshot messageSnapshot,
                  Animation<double> animation, int index) {
                return ChatMessageListItem(
                  messageSnapshot: messageSnapshot,
                  animation: animation,
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
          Builder(
            builder: (BuildContext context) {
              _scaffoldContext = context;
              return Container(
                width: 0,
                height: 0,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return GestureDetector(
      onTap: () {
        _dismissKeyboard(context);
      },
      child: IconTheme(
        data: IconThemeData(
            color: _isComposing
                ? Theme.of(context).accentColor
                : Theme.of(context).disabledColor),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () async {},
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposing = messageText.length > 0;
                    });
                  },
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? CupertinoButton(
                          child: Text("Send"),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        )
                      : IconButton(
                          icon: Icon(Icons.send),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        )),
            ]),
            decoration: Theme.of(context).platform == TargetPlatform.iOS
                ? BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[200])))
                : null),
      ),
    );
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();

    setState(() {
      _isComposing = false;
    });
    await _ensureLoggedIn();
    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    reference.push().set({
      'text': messageText,
      'email': widget.auth.getCurrentUser(),
      'imageUrl': imageUrl,
      // 'senderName': widget.auth.getCurrentUser(),
      // 'senderPhotoUrl': widget.auth.getCurrentUser()
    });
  }

  Future<Null> _ensureLoggedIn() async {
    currentUserEmail = widget.auth.getCurrentUser();
  }

  _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
