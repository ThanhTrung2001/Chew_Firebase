import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/comment_model.dart';
import 'package:firebase_tutorial/models/post_model.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:uuid/uuid.dart';

class PostFunction {
  final docPost = FirebaseFirestore.instance.collection('user');
//Post
  //Post CRUD
  // Stream<QuerySnapshot> getPostList(uid) {
  //   return;
  // }

  Stream<QuerySnapshot> getPostList(uid) {
    return docPost
        .doc(uid)
        .collection('post')
        .orderBy('date', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> createPost(PostModel post) async {
    final json = post.toJson();
    await docPost
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('post')
        .add(json);
  }

  Future<void> editPost(String id, PostModel post) async {
    final json = post.toJson();
    await docPost
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('post')
        .doc(id)
        .set(json);
  }

  Future<void> deletePost(String id) async {
    await docPost
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('post')
        .doc(id)
        .delete();
  }

  //Delete Comment
  // Future<bool> checkCommentFrom(
  //     String id, PostModel post, String contactID) async {
  //   return true;
  // }

  Stream<QuerySnapshot> getCommentList(postID, userID) {
    return docPost
        .doc(userID)
        .collection('post')
        .doc(postID)
        .collection('comment')
        .orderBy('date', descending: false)
        .snapshots(includeMetadataChanges: true);
  }

  Future<void> deleteComment(
      String id, String postID, String postUserUID) async {
    await docPost
        .doc(postUserUID)
        .collection('post')
        .doc(postID)
        .collection('comment')
        .doc(id)
        .delete();
  }

//Contact
  //Favorite
  Future<void> addOrRemoveFavorite(PostModel post, String contactID) async {}

  Future<bool> checkFavorite(String contactID) async {
    return true;
  }

  //Comment
  Future<void> commentOnPost(
      CommentModel comment, String postID, String postUserID) async {
    final json = comment.toJson();
    await docPost
        .doc(postUserID)
        .collection('post')
        .doc(postID)
        .collection('comment')
        .add(json);
  }
}
