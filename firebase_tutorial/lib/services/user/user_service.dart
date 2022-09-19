import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
late UserModel currentUser;

class UserFunction {
  final docUser = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    final user = auth.currentUser;
    // ignore: avoid_print
    print(user!.uid);
  }

  Future getUserInfoByID(String userID) async
  {
    final user = docUser.doc(userID).get().then((DocumentSnapshot document) {
      currentUser.uid = document.get('id');
      // ignore: avoid_print
      print(document.data());
    });
  }

  bool findUser() {
    // ignore: unnecessary_null_comparison
    if(docUser.doc(auth.currentUser!.uid).get() != null)
    {
      return true;
    }
    else
    {
      return false;
    }
  }


  Future createNewUser(userName, email, passWord, avtLink) async {
    final user =
        UserModel(auth.currentUser!.uid, userName, email, avtLink);
    final json = user.toJson();
    await docUser.doc(auth.currentUser!.uid).set(json);
  }

  Stream<List<UserModel>> readListAllUser() {
    return FirebaseFirestore.instance.collection('user').snapshots().map(
        ((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList()));
  }

  Future getUser(String userID) async {
    // ignore: unused_local_variable
    final user = docUser.doc(userID).get().then((DocumentSnapshot document) {
      currentUser.uid = document.get('id');
      // ignore: avoid_print
      print(document.data());
    });
  }

  Future<void> updateUser(String userID, UserModel user) async {
    docUser
        .doc(userID)
        .update({'name': user.userName}); 
  }
}
