import 'package:firebase_database/firebase_database.dart';

class Users {
  // String key;
  String userId;
  String name;
  String imageUrl;
  // DateTime createdAt;

  Users();

  Users.fromSnapshot(DataSnapshot snapshot)
      : userId = snapshot.value["userId"],
        name = snapshot.value["name"],
        imageUrl = snapshot.value["imageUrl"];

  toJson() {
    return {"userId": userId, "name": name, "imageUrl": imageUrl};
  }
}
