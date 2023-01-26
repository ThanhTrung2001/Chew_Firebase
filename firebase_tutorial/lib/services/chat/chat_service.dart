import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/chatroom_model.dart';
import 'package:firebase_tutorial/models/message_model.dart';

class ChatRoomFuction {
  final docChatRoom = FirebaseFirestore.instance.collection('chatroom');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> createChatRoom(ChatRoomModel chatRoomModel,
      String contactName, String currentUserName) async {
    chatRoomModel.userInRoom = [contactName, currentUserName];
    chatRoomModel.id = "${contactName}_${currentUserName}";
    String id2 = "${currentUserName}_${contactName}";
    final snapShot1 = await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatRoomModel.id)
        .get();
    final snapshot2 =
        await FirebaseFirestore.instance.collection("chatroom").doc(id2).get();
    if (snapShot1.exists) {
      print('exist chatroom1');
      return chatRoomModel.id;
    } else if (snapshot2.exists) {
      print('exist chatroom2');
      return id2;
    } else {
      final chatroom = ChatRoomModel(
          chatRoomModel.id,
          chatRoomModel.title,
          chatRoomModel.latestMessageContent,
          chatRoomModel.time,
          chatRoomModel.senderUID,
          chatRoomModel.userInRoom,
          chatRoomModel.avtLink);
      final json = chatroom.toJson();
      await docChatRoom.doc('${contactName}_${currentUserName}').set(json);
      print('new chatroom');
      return chatRoomModel.id;
    }
  }

  Stream<QuerySnapshot> getChatRoomList(username) {
    return docChatRoom
        .where('userInRoom', arrayContains: username)
        .snapshots(includeMetadataChanges: true);
  }
}
