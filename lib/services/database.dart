import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final firestore = FirebaseFirestore.instance;

  getUserByUserName(String username, QuerySnapshot mySnapshot) async {
    return await firestore
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
  }

  uploadUserInfo(userMap) {
    return firestore.collection('users').add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    firestore.collection('ChatRoom').doc(chatRoomId).set(chatRoomMap);
  }

  addMessages(String chatRoomId, messageMap) {
    firestore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chat')
        .add(messageMap);
  }
}
