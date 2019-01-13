import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Red extends StatefulWidget {
  @override
  _RedState createState() => _RedState();
}

class _RedState extends State<Red> {
  int perPage = 12;
  int present = 0;

  List<String> originalItems = List<String>.generate(1000, (i) => "Item $i");
  List<String> items = List<String>();

  @override
  void initState() {
    super.initState();
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      print(items);
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            (present <= originalItems.length) ? items.length + 1 : items.length,
        itemBuilder: (context, index) {
          return (index == items.length)
              ? Container(
                  color: Colors.greenAccent,
                  child: FlatButton(
                    child: Text("Load More"),
                    onPressed: () {
                      setState(() {
                        if ((present + perPage) > originalItems.length) {
                          items.addAll(originalItems.getRange(
                              present, originalItems.length));
                        } else {
                          items.addAll(originalItems.getRange(
                              present, present + perPage));
                        }
                        present = present + perPage;
                      });
                    },
                  ),
                )
              : ListTile(title: Text('${items[index]}'));
        });
  }
}
