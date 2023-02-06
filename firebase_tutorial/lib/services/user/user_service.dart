import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
late UserModel currentUser;

class UserFunction {
  final docUser = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future getUserInfoByID(String userID) async {
    return docUser.doc(userID).get().then((DocumentSnapshot document) {
      currentUser.uid = document.get('id');
      // ignore: avoid_print
      print(document.data());
    });
  }

  // bool findUser() {
  //   // ignore: unnecessary_null_comparison
  //   if (docUser.doc(auth.currentUser!.uid).get() != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future createNewUser(uid, userName, email, avtLink, status, bool inLive,
      description, List<String> followingID, List<String> followerID) async {
    final user =
        UserModel(uid, userName, email, avtLink, status, inLive, description);
    final json = user.toJson();
    await docUser.doc(uid).set(json);
  }

  Stream<List<UserModel>> readListAllUser() {
    return FirebaseFirestore.instance.collection('user').snapshots().map(
        ((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList()));
  }

  getUserList() {
    return FirebaseFirestore.instance
        .collection('user')
        .snapshots(includeMetadataChanges: true);
    // return userCollection;
  }

  searchuserByName(String search) {
    return FirebaseFirestore.instance
        .collection('user')
        .where('name', isEqualTo: search)
        .snapshots(includeMetadataChanges: true);
    // return userCollection;
  }

  Future getUser(String userID) async {
    // ignore: unused_local_variable
    final user = docUser.doc(userID).get().then((DocumentSnapshot document) {
      currentUser.uid = document.get('id');
      return document;
    });
  }

  Future<void> updateUser(
      String? userID, String name1, String description1) async {
    docUser.doc(userID).update({'name': name1, 'description': description1});
    FirebaseAuth.instance.currentUser!.updateDisplayName(name1);
  }

  Future<void> updateImage(String userID, String image) async {
    docUser.doc(userID).update({'avtLink': image});
    FirebaseAuth.instance.currentUser!.updatePhotoURL(image);
  }

  String? getUID() {
    return auth.currentUser?.uid;
  }

  Future<String?> getAvtLink(String userID) async {
    String? avtLink = '';
    final user = docUser.doc(userID).get().then((DocumentSnapshot document) {
      avtLink = document.get('avtLink');
    });
    return avtLink;
  }

  String? getFriendUID() {}
}
