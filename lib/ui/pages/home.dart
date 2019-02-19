import 'package:flutter/material.dart';
import 'package:closr/ui/widgets/photo_swipper.dart';
import 'package:closr/ui/widgets/chat.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            Text(
              "GOOD MORNING DARLINGS",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 200, child: ClosrSwipper()),
            Text("HAVE A GOOD PLAY AHEAD", textAlign: TextAlign.center),
            SizedBox(
                height: 200,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      color: Colors.red,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.green,
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.face),
                Text("CHAT AWAY", textAlign: TextAlign.center),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: ChatScreen()),
            )
          ],
        ),
      ),
    );
  }
}
