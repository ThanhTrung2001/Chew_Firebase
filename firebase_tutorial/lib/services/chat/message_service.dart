import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/message_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class MessageFunction {
  final docChatRoom = FirebaseFirestore.instance.collection('chatroom');
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getMessageList(id) {
    return docChatRoom
        .doc(id)
        .collection('chat')
        .orderBy('time', descending: false)
        .snapshots(includeMetadataChanges: true);
  }

  Future sendTextMessage(id, uid, messageContent) async{
    final messageModel = MessageModel(uid, false, messageContent, DateTime.now());
    final json = messageModel.toJson();
    updateLastMessage(id, messageModel, false);
    return docChatRoom.doc(id).collection('chat').doc(uuid.v4()).set(json);
    
  }

  Future sendImageMessage(id, uid, messagePhoto) async{
    final messageModel = MessageModel(uid, true, messagePhoto, DateTime.now());
    final json = messageModel.toJson();
    updateLastMessage(id, messageModel, true);
    return docChatRoom.doc(id).collection('chat').doc(uuid.v4()).set(json);
  }

    Future updateLastMessage(chatRoomID, MessageModel lastMessage, bool? isImage) async{
    return docChatRoom
        .doc(chatRoomID)
        .update({'senderUID': lastMessage.senderUID, 'time' : lastMessage.time, 'latestMessageContent': (isImage == false)? lastMessage.content : 'Image'});
  }
  
}
