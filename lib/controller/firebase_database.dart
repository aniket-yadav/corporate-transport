import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabase {
  static FirebaseFirestore chats = FirebaseFirestore.instance;

  static Future<void> sendMessage(
      {required String user,
      required String message,
      required String vehicle}) {
    return chats.collection(vehicle).add({
      "message": message,
      "time": DateTime.now().toIso8601String(),
      "user": user,
    });
  }

  static Stream<QuerySnapshot> getChats({required String vehicle}) {
    return chats.collection(vehicle).snapshots();
  }
}
