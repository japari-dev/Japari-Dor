import 'package:cloud_firestore/cloud_firestore.dart';

class GameService {
  static Future<DocumentReference> createGame() {
    return Firestore.instance.collection('/games').add({
      'createdAt': DateTime.now(),
    });
  }
}
