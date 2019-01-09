import 'package:firebase_database/firebase_database.dart';

class Touch {
  String key;
  final String content;
  final String senderId;
  final String receiverId;
  DateTime createAt;
  DateTime receivedAt;
  final bool completed;

  Touch(this.content, this.senderId, this.receiverId, this.completed);

  Touch.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        senderId = snapshot.value["senderId"],
        receiverId = snapshot.value["receiverId"],
        completed = snapshot.value["completed"],
        content = snapshot.value["content"];

  toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "complete": completed
    };
  }
}
