import 'package:flutter/material.dart';
// import 'closr_photoSwipper.dart';

class Closrhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double height = media.height.toDouble();
    double appBarSize = height / 15;
    double containerSize = height - appBarSize - 200;

    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(appBarSize),
        //   child: AppBar(
        //     title: Text("CLOSR"),
        //     elevation: 0.0,
        //     centerTitle: true,
        //     leading: IconButton(
        //       icon: Icon(Icons.menu, semanticLabel: 'menu'),
        //       onPressed: () {
        //         print('Menu button');
        //       },
        //     ),
        //     actions: <Widget>[
        //       FlatButton(
        //         child: Text(
        //           'LOGOUT',
        //         ),
        //         onPressed: () {},
        //       )
        //     ],
        //   ),
        // ),
        body: Container(
      color: Colors.teal,
      height: containerSize,
      // child: Column(
      //   children: <Widget>[
      //     profileSection(),
      //     Divider(
      //       height: 1.0,
      //     ),
      //     ClosrSwipper(),
      //     Divider(
      //       height: 1.0,
      //     ),
      //     // ClosrChat()
      //   ],
      // ),
    ));
  }

  Widget profileSection() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.grey[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              child: Image.asset('asset/images/dev.png'),
              backgroundColor: Colors.pink[50],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.green,
                  ),
                  Text('Lee is online')
                ]),
                Row(children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.pink,
                  ),
                  Text('Dev is offline')
                ]),
              ],
            ),
            CircleAvatar(
              radius: 30,
              child: Image.asset('asset/images/lee.png'),
              backgroundColor: Colors.green[50],
            ),
          ],
        ),
      ),
    );
  }

  // _signOut() async {
  //   try {
  //     await widget.auth.signOut();
  //     widget.onSignedOut();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
