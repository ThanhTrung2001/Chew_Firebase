import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/chatroom_model.dart';
import 'package:firebase_tutorial/models/message_model.dart';

class ChatRoomFuction {
  final docChatRoom = FirebaseFirestore.instance.collection('chatroom');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future createChatRoom(ChatRoomModel chatRoomModel, String contactName,
      String currentUserName) async {
    chatRoomModel.userInRoom = [contactName, currentUserName];
    chatRoomModel.id = "${currentUserName}_${contactName}";
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
  }

  Stream<QuerySnapshot> getChatRoomList(username){
    return docChatRoom.where('userInRoom', arrayContains: username).snapshots(includeMetadataChanges: true);
  }


  
}
